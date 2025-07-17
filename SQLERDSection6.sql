--SECTION 6
CREATE TABLE CarModel (
    modelID INT IDENTITY(1,1) PRIMARY KEY,
    modelName NVARCHAR(50) NOT NULL,
)

CREATE TABLE Dealer (
    dealerID INT IDENTITY(1,1) PRIMARY KEY,
    dealerName NVARCHAR(30) NOT NULL,
    location TEXT,
)

CREATE TABLE PromotionCampaign (
    campaignID INT IDENTITY(1,1) PRIMARY KEY,
    campaignName NVARCHAR(150) NOT NULL,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    discountAmount FLOAT NOT NULL,
    marketingRegion NVARCHAR(100)
);


CREATE TABLE PromotionCampaignCarModelDealer (
    campaignID INT NOT NULL,
    modelID INT NOT NULL,
    dealerID INT NOT NULL,
    PRIMARY KEY (campaignID, modelID, dealerID),
    FOREIGN KEY (campaignID) REFERENCES PromotionCampaign(campaignID),
    FOREIGN KEY (modelID) REFERENCES CarModel(modelID),
    FOREIGN KEY (dealerID) REFERENCES Dealer(dealerID)
);


CREATE TABLE CustomerBenefit (
    benefitID INT IDENTITY(1,1) PRIMARY KEY,
    campaignID INT NOT NULL,
    dealerID INT NOT NULL,
    customerName NVARCHAR(150) NOT NULL,
    vin NVARCHAR(50) NOT NULL,
    eligibleDate DATE NOT NULL,
    FOREIGN KEY (campaignID) REFERENCES PromotionCampaign(campaignID),
    FOREIGN KEY (dealerID) REFERENCES Dealer(dealerID)
);
