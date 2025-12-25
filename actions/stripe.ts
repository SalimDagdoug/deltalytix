import 'server-only'

import Stripe from "stripe";

// Make Stripe optional - return null if no API key is configured
// This is useful for personal/self-hosted deployments that don't need payments
const stripeApiKey = process.env.STRIPE_SECRET_KEY;

export const stripe = stripeApiKey 
  ? new Stripe(stripeApiKey, {
      // https://github.com/stripe/stripe-node#configuration
      apiVersion: "2025-10-29.clover",
    })
  : null;

// Helper to check if Stripe is configured
export const isStripeConfigured = () => stripe !== null;