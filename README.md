An Azure Blockchain Workbench Application for Managing Azure CSP Credits 
================================================================================

Overview 
---------

The AzureCSPCredits application expresses a workflow for a simple transaction
between a CSP and a buyer of Azure CSP Credits.  The state transition diagram
below shows the interactions among the states in this workflow. 

Application Roles 
------------------
| Name                   | Description                                       |
|------------------------|---------------------------------------------------|
|AzureCSP |A CSP who wants to sell Azure Credits on the marketplace.         |
|Buyer    |A customer who wants to buy Azure Credits from the marketplace.   |

States 
-------

| Name                   | Description                                       |
|------------------------|---------------------------------------------------|
|CreditsAvailable |Indicates that a CSP has made a number of credits available at a price and a value for a customer in the marketplace. 
|ManageCredits |Indicates that Buyer has accepted the Credits and he can Activate the Credits or Request for more.
|MakeOffer |Indicates that CSP has placed a new offer for the requested number Credits.
|Terminated | Indicates that CSP has terminated the contract. 

Workflow Details
----------------

![workflow details for application](media/worfkflow.png)

An instance of the AzureCSPCredits application's workflow starts in the CreditsAvailable state when a CSP makes a number of credits available for use by specifying its quitity, value and price.  A buyer can then accept or reject the credits.  This action causes the state to change from MaageCredits state to CreditsAvailable state. At MakeOffer state the CSP can place an offer to the buyer for the requested number of credits and the state changes to CreditsAvailable state. 

 
 
Application Files
-----------------

[AzureCSPCredits.json](./ethereum/AzureCSPCredits.json)

[AzureCSPCredits.json.sol](./ethereum/AzureCSPCredits.json.sol)

