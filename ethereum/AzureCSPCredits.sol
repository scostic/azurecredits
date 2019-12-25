pragma solidity >=0.4.25 <0.6.0;

contract AzureCSPCredits
{
    enum StateType { 
      CreditsAvailable,
      ManageCredits,
      MakeOffer,
	  Terminated
    }
    address public CreditOwner;

    address public CreditBuyer;
    int public OfferQty;
    int public OfferPrice;
	int public TotalCreditPrice;
	int public CreditPrice;
	int public TotalCreditQty;
	int public ActiveQty;
	int public RequestQty;
    StateType public State;


    constructor(int qty, int price) public
    {
        CreditOwner = msg.sender;
        OfferPrice = price;
        OfferQty = qty;
		TotalCreditQty = 0;
		ActiveQty = 0;
		TotalCreditPrice = 0;
		CreditPrice = price;
        State = StateType.CreditsAvailable;
    }

    
    function Reject() public
    {
        if ( State != StateType.CreditsAvailable )
        {
            revert();
        }

        CreditBuyer = 0x0000000000000000000000000000000000000000;

        State = StateType.ManageCredits;
    }

    function AcceptOffer() public
    {
        if ( State != StateType.CreditsAvailable )
        {
            revert();
        }
		CreditBuyer = msg.sender;
		
        TotalCreditQty = TotalCreditQty + OfferQty;
		TotalCreditPrice = TotalCreditPrice + CreditPrice*OfferQty;
        State = StateType.ManageCredits;
    }
	
	function RequestCredits(int qty) public
    {
        if ( msg.sender != CreditBuyer )
        {
            revert();
        }
		if (qty == 0)
        {
            revert();
        }
        RequestQty = qty;
		
        State = StateType.MakeOffer;
    }
	
	function MakeOffer(int qty, int price) public
    {
        if (qty == 0)
        {
            revert();
        }
		if (price == 0)
        {
            revert();
        }
		
	    if (State != StateType.MakeOffer)
        {
            revert();
        }
        
        if (msg.sender != CreditOwner)
        {
            revert();
        }

        OfferQty = qty;
        OfferPrice = price;
        State = StateType.CreditsAvailable;
    }

	function ActivateCredits(int qty) public
    {
        if ( msg.sender != CreditBuyer )
        {
            revert();
        }
		if (qty == 0)
        {
            revert();
        }
        if (qty > TotalCreditQty)
		{
            revert();
        }
        
		ActiveQty = ActiveQty + qty;
		TotalCreditQty = TotalCreditQty - qty;
		
        State = StateType.ManageCredits;
    }
	
	function Terminate() public
    {
        if ( msg.sender != CreditOwner )
        {
            revert();
        }
		
        State = StateType.Terminated;
    }
}
