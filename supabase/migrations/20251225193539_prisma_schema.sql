-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "public";

-- CreateEnum
CREATE TYPE "public"."PostType" AS ENUM ('FEATURE_REQUEST', 'BUG_REPORT', 'DISCUSSION');

-- CreateEnum
CREATE TYPE "public"."PostStatus" AS ENUM ('OPEN', 'IN_PROGRESS', 'COMPLETED', 'CLOSED');

-- CreateEnum
CREATE TYPE "public"."VoteType" AS ENUM ('UPVOTE', 'DOWNVOTE');

-- CreateEnum
CREATE TYPE "public"."PaymentFrequency" AS ENUM ('MONTHLY', 'QUARTERLY', 'BIANNUAL', 'ANNUAL', 'CUSTOM');

-- CreateEnum
CREATE TYPE "public"."PromoType" AS ENUM ('DIRECT', 'PERCENTAGE');

-- CreateTable
CREATE TABLE "public"."Trade" (
    "id" TEXT NOT NULL,
    "accountNumber" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "entryId" TEXT DEFAULT '',
    "closeId" TEXT DEFAULT '',
    "instrument" TEXT NOT NULL,
    "entryPrice" TEXT NOT NULL,
    "closePrice" TEXT NOT NULL,
    "entryDate" TEXT NOT NULL,
    "closeDate" TEXT NOT NULL,
    "pnl" DOUBLE PRECISION NOT NULL,
    "timeInPosition" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "userId" TEXT NOT NULL,
    "side" TEXT DEFAULT '',
    "commission" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "comment" TEXT,
    "tags" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "imageBase64" TEXT,
    "videoUrl" TEXT,
    "imageBase64Second" TEXT,
    "groupId" TEXT DEFAULT '',
    "images" TEXT[] DEFAULT ARRAY[]::TEXT[],

    CONSTRAINT "Trade_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."TickDetails" (
    "id" TEXT NOT NULL,
    "ticker" TEXT NOT NULL,
    "tickValue" DOUBLE PRECISION NOT NULL,
    "tickSize" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "TickDetails_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Subscription" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "plan" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" TEXT NOT NULL,
    "endDate" TIMESTAMP(3),
    "status" TEXT NOT NULL DEFAULT 'ACTIVE',
    "trialEndsAt" TIMESTAMP(3),
    "interval" TEXT,

    CONSTRAINT "Subscription_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."BusinessSubscription" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "plan" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" TEXT NOT NULL,
    "businessId" TEXT NOT NULL,
    "endDate" TIMESTAMP(3),
    "status" TEXT NOT NULL DEFAULT 'ACTIVE',
    "trialEndsAt" TIMESTAMP(3),
    "interval" TEXT,

    CONSTRAINT "BusinessSubscription_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."TeamSubscription" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "plan" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" TEXT NOT NULL,
    "teamId" TEXT NOT NULL,
    "endDate" TIMESTAMP(3),
    "status" TEXT NOT NULL DEFAULT 'ACTIVE',
    "trialEndsAt" TIMESTAMP(3),
    "interval" TEXT,

    CONSTRAINT "TeamSubscription_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Notification" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "readAt" TIMESTAMP(3),

    CONSTRAINT "Notification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."User" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "auth_user_id" TEXT NOT NULL,
    "isFirstConnection" BOOLEAN NOT NULL DEFAULT true,
    "etpToken" TEXT,
    "isBeta" BOOLEAN NOT NULL DEFAULT false,
    "language" TEXT NOT NULL DEFAULT 'en',
    "thorToken" TEXT,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Synchronization" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "service" TEXT NOT NULL,
    "accountId" TEXT NOT NULL,
    "lastSyncedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "token" TEXT,
    "tokenExpiresAt" TIMESTAMP(3),
    "dailySyncTime" TIMESTAMP(3),

    CONSTRAINT "Synchronization_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Team" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "traderIds" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Team_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."TeamInvitation" (
    "id" TEXT NOT NULL,
    "teamId" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "invitedBy" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'PENDING',
    "expiresAt" TIMESTAMP(3) NOT NULL DEFAULT (now() + '7 days'::interval),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TeamInvitation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."TeamManager" (
    "id" TEXT NOT NULL,
    "teamId" TEXT NOT NULL,
    "managerId" TEXT NOT NULL,
    "access" TEXT NOT NULL DEFAULT 'viewer',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TeamManager_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Business" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "traderIds" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Business_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."BusinessManager" (
    "id" TEXT NOT NULL,
    "businessId" TEXT NOT NULL,
    "managerId" TEXT NOT NULL,
    "access" TEXT NOT NULL DEFAULT 'viewer',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "BusinessManager_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."BusinessInvitation" (
    "id" TEXT NOT NULL,
    "businessId" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "invitedBy" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'PENDING',
    "expiresAt" TIMESTAMP(3) NOT NULL DEFAULT (now() + '7 days'::interval),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "BusinessInvitation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Group" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Group_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Account" (
    "id" TEXT NOT NULL,
    "number" TEXT NOT NULL,
    "propfirm" TEXT NOT NULL DEFAULT '',
    "drawdownThreshold" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "profitTarget" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "isPerformance" BOOLEAN NOT NULL DEFAULT false,
    "userId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "startingBalance" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "payoutCount" INTEGER NOT NULL DEFAULT 0,
    "trailingDrawdown" BOOLEAN NOT NULL DEFAULT false,
    "trailingStopProfit" DOUBLE PRECISION,
    "resetDate" TIMESTAMP(3),
    "consistencyPercentage" DOUBLE PRECISION DEFAULT 30,
    "groupId" TEXT,
    "accountSize" TEXT,
    "accountSizeName" TEXT,
    "activationFees" DOUBLE PRECISION,
    "balanceRequired" DOUBLE PRECISION,
    "dailyLoss" DOUBLE PRECISION,
    "evaluation" BOOLEAN NOT NULL DEFAULT true,
    "isRecursively" TEXT,
    "maxFundedAccounts" INTEGER,
    "maxPayout" TEXT,
    "minDays" INTEGER,
    "minPayout" DOUBLE PRECISION,
    "minTradingDaysForPayout" INTEGER,
    "payoutBonus" DOUBLE PRECISION,
    "payoutPolicy" TEXT,
    "price" DOUBLE PRECISION,
    "priceWithPromo" DOUBLE PRECISION,
    "profitSharing" DOUBLE PRECISION,
    "rulesDailyLoss" TEXT,
    "tradingNewsAllowed" BOOLEAN NOT NULL DEFAULT true,
    "trailing" TEXT,
    "autoRenewal" BOOLEAN NOT NULL DEFAULT false,
    "nextPaymentDate" TIMESTAMP(3),
    "paymentFrequency" "public"."PaymentFrequency",
    "promoPercentage" DOUBLE PRECISION,
    "promoType" "public"."PromoType",
    "renewalNotice" INTEGER,
    "minPnlToCountAsDay" DOUBLE PRECISION,
    "buffer" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "considerBuffer" BOOLEAN NOT NULL DEFAULT true,
    "shouldConsiderTradesBeforeReset" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "Account_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Payout" (
    "id" TEXT NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "status" TEXT NOT NULL DEFAULT 'PENDING',
    "accountNumber" TEXT NOT NULL,
    "accountId" TEXT NOT NULL,

    CONSTRAINT "Payout_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."DashboardLayout" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "desktop" JSONB NOT NULL DEFAULT '[]',
    "mobile" JSONB NOT NULL DEFAULT '[]',

    CONSTRAINT "DashboardLayout_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."SubscriptionFeedback" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "event" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "cancellationReason" TEXT,
    "feedback" TEXT,

    CONSTRAINT "SubscriptionFeedback_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Mood" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "day" TIMESTAMP(3) NOT NULL,
    "mood" TEXT NOT NULL,
    "conversation" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "emotionValue" INTEGER NOT NULL DEFAULT 50,
    "hasTradingExperience" BOOLEAN,
    "journalContent" TEXT,
    "selectedNews" TEXT[] DEFAULT ARRAY[]::TEXT[],

    CONSTRAINT "Mood_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Shared" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "title" TEXT,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" TIMESTAMP(3),
    "isPublic" BOOLEAN NOT NULL DEFAULT true,
    "viewCount" INTEGER NOT NULL DEFAULT 0,
    "accountNumbers" TEXT[],
    "dateRange" JSONB NOT NULL,
    "desktop" JSONB NOT NULL DEFAULT '[]',
    "mobile" JSONB NOT NULL DEFAULT '[]',

    CONSTRAINT "Shared_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Referral" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "referredUserIds" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Referral_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."FinancialEvent" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "importance" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "sourceUrl" TEXT,
    "country" TEXT,
    "lang" TEXT NOT NULL DEFAULT 'fr',
    "timezone" TEXT NOT NULL DEFAULT 'UTC',

    CONSTRAINT "FinancialEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Tag" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "color" TEXT DEFAULT '#CBD5E1',
    "userId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Tag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Newsletter" (
    "email" TEXT NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "firstName" TEXT,
    "lastName" TEXT,

    CONSTRAINT "Newsletter_pkey" PRIMARY KEY ("email")
);

-- CreateTable
CREATE TABLE "public"."Post" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "type" "public"."PostType" NOT NULL DEFAULT 'FEATURE_REQUEST',
    "status" "public"."PostStatus" NOT NULL DEFAULT 'OPEN',
    "userId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "screenshots" TEXT[] DEFAULT ARRAY[]::TEXT[],

    CONSTRAINT "Post_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Comment" (
    "id" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "postId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "parentId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Comment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Vote" (
    "id" TEXT NOT NULL,
    "type" "public"."VoteType" NOT NULL,
    "postId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Vote_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Order" (
    "id" TEXT NOT NULL,
    "accountId" TEXT NOT NULL,
    "orderId" TEXT NOT NULL,
    "orderAction" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "averageFilledPrice" DOUBLE PRECISION NOT NULL,
    "isOpeningOrder" BOOLEAN NOT NULL,
    "time" TIMESTAMP(3) NOT NULL,
    "symbol" TEXT NOT NULL,
    "instrumentType" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Order_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."TradeAnalytics" (
    "id" TEXT NOT NULL,
    "tradeId" TEXT NOT NULL,
    "mae" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "mfe" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "entryPriceFromData" DOUBLE PRECISION,
    "priceDifference" DOUBLE PRECISION,
    "riskRewardRatio" DOUBLE PRECISION,
    "efficiency" DOUBLE PRECISION,
    "dataSource" TEXT NOT NULL DEFAULT 'DATABENTO',
    "computedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TradeAnalytics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."HistoricalData" (
    "id" TEXT NOT NULL,
    "symbol" TEXT NOT NULL,
    "databentSymbol" TEXT NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL,
    "open" DOUBLE PRECISION NOT NULL,
    "high" DOUBLE PRECISION NOT NULL,
    "low" DOUBLE PRECISION NOT NULL,
    "close" DOUBLE PRECISION NOT NULL,
    "volume" INTEGER NOT NULL,
    "dataSource" TEXT NOT NULL DEFAULT 'DATABENTO',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "HistoricalData_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Trade_id_key" ON "public"."Trade"("id");

-- CreateIndex
CREATE INDEX "Trade_accountNumber_idx" ON "public"."Trade"("accountNumber");

-- CreateIndex
CREATE INDEX "Trade_groupId_idx" ON "public"."Trade"("groupId");

-- CreateIndex
CREATE UNIQUE INDEX "TickDetails_id_key" ON "public"."TickDetails"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Subscription_id_key" ON "public"."Subscription"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Subscription_email_key" ON "public"."Subscription"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Subscription_userId_key" ON "public"."Subscription"("userId");

-- CreateIndex
CREATE INDEX "Subscription_email_idx" ON "public"."Subscription"("email");

-- CreateIndex
CREATE UNIQUE INDEX "BusinessSubscription_id_key" ON "public"."BusinessSubscription"("id");

-- CreateIndex
CREATE UNIQUE INDEX "BusinessSubscription_email_key" ON "public"."BusinessSubscription"("email");

-- CreateIndex
CREATE UNIQUE INDEX "BusinessSubscription_userId_key" ON "public"."BusinessSubscription"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "BusinessSubscription_businessId_key" ON "public"."BusinessSubscription"("businessId");

-- CreateIndex
CREATE INDEX "BusinessSubscription_email_idx" ON "public"."BusinessSubscription"("email");

-- CreateIndex
CREATE INDEX "BusinessSubscription_userId_idx" ON "public"."BusinessSubscription"("userId");

-- CreateIndex
CREATE INDEX "BusinessSubscription_businessId_idx" ON "public"."BusinessSubscription"("businessId");

-- CreateIndex
CREATE UNIQUE INDEX "TeamSubscription_id_key" ON "public"."TeamSubscription"("id");

-- CreateIndex
CREATE UNIQUE INDEX "TeamSubscription_email_key" ON "public"."TeamSubscription"("email");

-- CreateIndex
CREATE UNIQUE INDEX "TeamSubscription_userId_key" ON "public"."TeamSubscription"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "TeamSubscription_teamId_key" ON "public"."TeamSubscription"("teamId");

-- CreateIndex
CREATE INDEX "TeamSubscription_email_idx" ON "public"."TeamSubscription"("email");

-- CreateIndex
CREATE INDEX "TeamSubscription_userId_idx" ON "public"."TeamSubscription"("userId");

-- CreateIndex
CREATE INDEX "TeamSubscription_teamId_idx" ON "public"."TeamSubscription"("teamId");

-- CreateIndex
CREATE INDEX "Notification_userId_idx" ON "public"."Notification"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "public"."User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_auth_user_id_key" ON "public"."User"("auth_user_id");

-- CreateIndex
CREATE INDEX "User_email_idx" ON "public"."User"("email");

-- CreateIndex
CREATE INDEX "Synchronization_userId_idx" ON "public"."Synchronization"("userId");

-- CreateIndex
CREATE INDEX "Synchronization_service_idx" ON "public"."Synchronization"("service");

-- CreateIndex
CREATE UNIQUE INDEX "Synchronization_userId_service_accountId_key" ON "public"."Synchronization"("userId", "service", "accountId");

-- CreateIndex
CREATE INDEX "Team_userId_idx" ON "public"."Team"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Team_name_userId_key" ON "public"."Team"("name", "userId");

-- CreateIndex
CREATE INDEX "TeamInvitation_teamId_idx" ON "public"."TeamInvitation"("teamId");

-- CreateIndex
CREATE INDEX "TeamInvitation_email_idx" ON "public"."TeamInvitation"("email");

-- CreateIndex
CREATE INDEX "TeamInvitation_status_idx" ON "public"."TeamInvitation"("status");

-- CreateIndex
CREATE UNIQUE INDEX "TeamInvitation_teamId_email_key" ON "public"."TeamInvitation"("teamId", "email");

-- CreateIndex
CREATE INDEX "TeamManager_teamId_idx" ON "public"."TeamManager"("teamId");

-- CreateIndex
CREATE INDEX "TeamManager_managerId_idx" ON "public"."TeamManager"("managerId");

-- CreateIndex
CREATE UNIQUE INDEX "TeamManager_teamId_managerId_key" ON "public"."TeamManager"("teamId", "managerId");

-- CreateIndex
CREATE INDEX "Business_userId_idx" ON "public"."Business"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Business_name_userId_key" ON "public"."Business"("name", "userId");

-- CreateIndex
CREATE INDEX "BusinessManager_businessId_idx" ON "public"."BusinessManager"("businessId");

-- CreateIndex
CREATE INDEX "BusinessManager_managerId_idx" ON "public"."BusinessManager"("managerId");

-- CreateIndex
CREATE UNIQUE INDEX "BusinessManager_businessId_managerId_key" ON "public"."BusinessManager"("businessId", "managerId");

-- CreateIndex
CREATE INDEX "BusinessInvitation_businessId_idx" ON "public"."BusinessInvitation"("businessId");

-- CreateIndex
CREATE INDEX "BusinessInvitation_email_idx" ON "public"."BusinessInvitation"("email");

-- CreateIndex
CREATE INDEX "BusinessInvitation_status_idx" ON "public"."BusinessInvitation"("status");

-- CreateIndex
CREATE UNIQUE INDEX "BusinessInvitation_businessId_email_key" ON "public"."BusinessInvitation"("businessId", "email");

-- CreateIndex
CREATE INDEX "Group_userId_idx" ON "public"."Group"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Group_name_userId_key" ON "public"."Group"("name", "userId");

-- CreateIndex
CREATE UNIQUE INDEX "Account_id_key" ON "public"."Account"("id");

-- CreateIndex
CREATE INDEX "Account_number_idx" ON "public"."Account"("number");

-- CreateIndex
CREATE INDEX "Account_groupId_idx" ON "public"."Account"("groupId");

-- CreateIndex
CREATE INDEX "Account_nextPaymentDate_idx" ON "public"."Account"("nextPaymentDate");

-- CreateIndex
CREATE UNIQUE INDEX "Account_number_userId_key" ON "public"."Account"("number", "userId");

-- CreateIndex
CREATE INDEX "Payout_accountNumber_idx" ON "public"."Payout"("accountNumber");

-- CreateIndex
CREATE UNIQUE INDEX "DashboardLayout_userId_key" ON "public"."DashboardLayout"("userId");

-- CreateIndex
CREATE INDEX "DashboardLayout_userId_idx" ON "public"."DashboardLayout"("userId");

-- CreateIndex
CREATE INDEX "SubscriptionFeedback_email_idx" ON "public"."SubscriptionFeedback"("email");

-- CreateIndex
CREATE INDEX "Mood_userId_idx" ON "public"."Mood"("userId");

-- CreateIndex
CREATE INDEX "Mood_day_idx" ON "public"."Mood"("day");

-- CreateIndex
CREATE UNIQUE INDEX "Mood_userId_day_key" ON "public"."Mood"("userId", "day");

-- CreateIndex
CREATE UNIQUE INDEX "Shared_slug_key" ON "public"."Shared"("slug");

-- CreateIndex
CREATE INDEX "Shared_userId_idx" ON "public"."Shared"("userId");

-- CreateIndex
CREATE INDEX "Shared_slug_idx" ON "public"."Shared"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Referral_userId_key" ON "public"."Referral"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Referral_slug_key" ON "public"."Referral"("slug");

-- CreateIndex
CREATE INDEX "Referral_userId_idx" ON "public"."Referral"("userId");

-- CreateIndex
CREATE INDEX "Referral_slug_idx" ON "public"."Referral"("slug");

-- CreateIndex
CREATE INDEX "FinancialEvent_date_idx" ON "public"."FinancialEvent"("date");

-- CreateIndex
CREATE UNIQUE INDEX "FinancialEvent_title_date_lang_timezone_key" ON "public"."FinancialEvent"("title", "date", "lang", "timezone");

-- CreateIndex
CREATE INDEX "Tag_userId_idx" ON "public"."Tag"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Tag_name_userId_key" ON "public"."Tag"("name", "userId");

-- CreateIndex
CREATE UNIQUE INDEX "Newsletter_email_key" ON "public"."Newsletter"("email");

-- CreateIndex
CREATE INDEX "Newsletter_email_idx" ON "public"."Newsletter"("email");

-- CreateIndex
CREATE INDEX "Post_userId_idx" ON "public"."Post"("userId");

-- CreateIndex
CREATE INDEX "Post_type_idx" ON "public"."Post"("type");

-- CreateIndex
CREATE INDEX "Post_status_idx" ON "public"."Post"("status");

-- CreateIndex
CREATE INDEX "Comment_postId_idx" ON "public"."Comment"("postId");

-- CreateIndex
CREATE INDEX "Comment_userId_idx" ON "public"."Comment"("userId");

-- CreateIndex
CREATE INDEX "Comment_parentId_idx" ON "public"."Comment"("parentId");

-- CreateIndex
CREATE INDEX "Vote_postId_idx" ON "public"."Vote"("postId");

-- CreateIndex
CREATE INDEX "Vote_userId_idx" ON "public"."Vote"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Vote_postId_userId_key" ON "public"."Vote"("postId", "userId");

-- CreateIndex
CREATE UNIQUE INDEX "Order_orderId_key" ON "public"."Order"("orderId");

-- CreateIndex
CREATE INDEX "Order_accountId_idx" ON "public"."Order"("accountId");

-- CreateIndex
CREATE INDEX "Order_userId_idx" ON "public"."Order"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "TradeAnalytics_tradeId_key" ON "public"."TradeAnalytics"("tradeId");

-- CreateIndex
CREATE INDEX "TradeAnalytics_tradeId_idx" ON "public"."TradeAnalytics"("tradeId");

-- CreateIndex
CREATE INDEX "TradeAnalytics_computedAt_idx" ON "public"."TradeAnalytics"("computedAt");

-- CreateIndex
CREATE INDEX "HistoricalData_symbol_idx" ON "public"."HistoricalData"("symbol");

-- CreateIndex
CREATE INDEX "HistoricalData_databentSymbol_idx" ON "public"."HistoricalData"("databentSymbol");

-- CreateIndex
CREATE INDEX "HistoricalData_timestamp_idx" ON "public"."HistoricalData"("timestamp");

-- CreateIndex
CREATE UNIQUE INDEX "HistoricalData_symbol_databentSymbol_timestamp_key" ON "public"."HistoricalData"("symbol", "databentSymbol", "timestamp");

-- AddForeignKey
ALTER TABLE "public"."Subscription" ADD CONSTRAINT "Subscription_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."BusinessSubscription" ADD CONSTRAINT "BusinessSubscription_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."BusinessSubscription" ADD CONSTRAINT "BusinessSubscription_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "public"."Business"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."TeamSubscription" ADD CONSTRAINT "TeamSubscription_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."TeamSubscription" ADD CONSTRAINT "TeamSubscription_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Notification" ADD CONSTRAINT "Notification_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Synchronization" ADD CONSTRAINT "Synchronization_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Team" ADD CONSTRAINT "Team_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."TeamInvitation" ADD CONSTRAINT "TeamInvitation_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."TeamManager" ADD CONSTRAINT "TeamManager_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "public"."Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Business" ADD CONSTRAINT "Business_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."BusinessManager" ADD CONSTRAINT "BusinessManager_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "public"."Business"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."BusinessInvitation" ADD CONSTRAINT "BusinessInvitation_businessId_fkey" FOREIGN KEY ("businessId") REFERENCES "public"."Business"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Group" ADD CONSTRAINT "Group_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Account" ADD CONSTRAINT "Account_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "public"."Group"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Account" ADD CONSTRAINT "Account_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Payout" ADD CONSTRAINT "Payout_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "public"."Account"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."DashboardLayout" ADD CONSTRAINT "DashboardLayout_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("auth_user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Mood" ADD CONSTRAINT "Mood_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Referral" ADD CONSTRAINT "Referral_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Tag" ADD CONSTRAINT "Tag_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Post" ADD CONSTRAINT "Post_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Comment" ADD CONSTRAINT "Comment_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "public"."Comment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Comment" ADD CONSTRAINT "Comment_postId_fkey" FOREIGN KEY ("postId") REFERENCES "public"."Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Comment" ADD CONSTRAINT "Comment_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Vote" ADD CONSTRAINT "Vote_postId_fkey" FOREIGN KEY ("postId") REFERENCES "public"."Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Vote" ADD CONSTRAINT "Vote_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Order" ADD CONSTRAINT "Order_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

