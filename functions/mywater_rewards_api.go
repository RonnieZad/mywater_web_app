package mywaterRewardsApi

import (
	"context"
	"encoding/json"
	"fmt"
	"html"
	"log"
	"net/http"
	"time"

	firebase "firebase.google.com/go"
	"firebase.google.com/go/auth"
	"cloud.google.com/go/firestore"
	"github.com/GoogleCloudPlatform/functions-framework-go/functions"
	"google.golang.org/api/option"
)

var firestoreClient *firestore.Client
var firebaseAuthClient *auth.Client

func init() {
	// Initialize Firebase App
	opt := option.WithCredentialsFile("/Users/rtv-lpt-237/dev/mywater_web_app/functions/serviceAccountKey.json")
	config := &firebase.Config{ProjectID: "mywater-abc"}
	app, err := firebase.NewApp(context.Background(), config, opt)
	if err != nil {
		log.Fatalf("Error initializing Firebase App: %v", err)
	}

	// Initialize Firestore client
	firestoreClient, err = app.Firestore(context.Background())
	if err != nil {
		log.Fatalf("Error initializing Firestore: %v", err)
	}


	functions.HTTP("RedeemReward", RedeemReward)
}

// RewardRequest is the struct to receive reward details from the request
type RewardRequest struct {
	SubscriberID string `json:"subscriber_id"`
	RewardType   string `json:"reward_type"`   // "airtime" or "data"
	Amount       int    `json:"amount"`        // Amount in local currency for airtime or MB for data
}

// RedeemReward handles redeeming airtime or data rewards and updating Firestore
func RedeemReward(w http.ResponseWriter, r *http.Request) {
	var rewardReq RewardRequest
	if err := json.NewDecoder(r.Body).Decode(&rewardReq); err != nil {
		http.Error(w, "Invalid request payload", http.StatusBadRequest)
		return
	}

	// Validate request
	if rewardReq.SubscriberID == "" || rewardReq.Amount <= 0 || (rewardReq.RewardType != "airtime" && rewardReq.RewardType != "data") {
		http.Error(w, "Invalid reward details", http.StatusBadRequest)
		return
	}

	// Call a function to redeem reward
	if err := redeemRewardToSubscriber(rewardReq); err != nil {
		http.Error(w, fmt.Sprintf("Failed to redeem reward: %v", err), http.StatusInternalServerError)
		return
	}

	// Update Firestore with transaction details
	if err := updateTransactionInFirestore(rewardReq); err != nil {
		http.Error(w, fmt.Sprintf("Reward redeemed but failed to update Firestore: %v", err), http.StatusInternalServerError)
		return
	}

	// Success response
	fmt.Fprintf(w, "Reward of %d %s redeemed for subscriber %s", rewardReq.Amount, html.EscapeString(rewardReq.RewardType), html.EscapeString(rewardReq.SubscriberID))
}

// Simulate the redemption logic with an external service (telecom API)
func redeemRewardToSubscriber(req RewardRequest) error {
	if req.RewardType == "airtime" {
		fmt.Printf("Redeeming %d UGX airtime for subscriber %s\n", req.Amount, req.SubscriberID)
	} else if req.RewardType == "data" {
		fmt.Printf("Redeeming %d MB data for subscriber %s\n", req.Amount, req.SubscriberID)
	} else {
		return fmt.Errorf("unknown reward type")
	}
	return nil
}

// Update Firestore with transaction status
func updateTransactionInFirestore(req RewardRequest) error {
	ctx := context.Background()
	// Reference to the subscriber's document in Firestore
	docRef := firestoreClient.Collection("transactions").Doc(req.SubscriberID)

	// Update or create a new transaction entry
	_, err := docRef.Set(ctx, map[string]interface{}{
		"subscriber_id": req.SubscriberID,
		"reward_type":   req.RewardType,
		"amount":        req.Amount,
		"status":        "success",
		"timestamp":     time.Now(),
	}, firestore.MergeAll)
	if err != nil {
		return fmt.Errorf("failed to update Firestore: %v", err)
	}

	fmt.Printf("Firestore updated for subscriber %s\n", req.SubscriberID)
	return nil
}