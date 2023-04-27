/**
 * 
 */
autoBid.addEventListener("change", autoBidOnChange);
bid.addEventListener("click", bidFunctionality);


function autoBidOnChange() {
    const autoBidVal = document.getElementById("autoBid").checked;
    if (autoBidVal) {
        document.getElementById("secretUpperLimit").disabled = false;
        document.getElementById("autoBidIncrement").disabled = false;
    } else {
        document.getElementById("secretUpperLimit").disabled = true;
        document.getElementById("autoBidIncrement").disabled = true;
    }
}

function bidFunctionality() {
    const bidAmt = document.getElementById("bidAmount").value;
    const currBidAmt = document.getElementById("currBiddingPrice").innerHTML;
    const item_Id = document.getElementById("item_id").value;
    //add time passed check
    
    if (!parseInt(bidAmt)) {
        alert("Please enter bid amount");
        return false;
    }
    if (parseInt(bidAmt) <= parseInt(currBidAmt)) {
        alert("Your Bid Amount cannot be less than or equal to current bidding amount.");
        return false;
    }
    const anonymousCheckbox = document.getElementById("anonymousBid").checked;
    const enableAutoBid = document.getElementById("autoBid").checked;
    const secretUpperLimit = document.getElementById("secretUpperLimit").value;
    const autoBidIncrement = document.getElementById("autoBidIncrement").value;
	if(enableAutoBid && (secretUpperLimit == "" ||  autoBidIncrement == "")){
		alert("Please enter Secret Upper Limit and Auto Bid Increment fields.");
        return false;
	}
    var json_Payload = {
        "item_id": item_Id,
        "bid_Amt": bidAmt,
        "isAnonymous": anonymousCheckbox,
        "isAutoBid": enableAutoBid,
        "SecretUpperLimit": secretUpperLimit,
        "AutoBidIncrement": autoBidIncrement
    };

    var http_request = new XMLHttpRequest();
    try {
        // Opera 8.0+, Firefox, Chrome, Safari
        http_request = new XMLHttpRequest();
    } catch (e) {
        // Internet Explorer Browsers
        try {
            http_request = new ActiveXObject("Msxml2.XMLHTTP");

        } catch (e) {

            try {
                http_request = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (e) {
                // Something went wrong
                alert("Your browser broke!");
                return false;
            }

        }
    }
    const url = "bid";


    http_request.open("POST", url, false);
	http_request.setRequestHeader("Content-Type", "application/json");
	
    http_request.send(JSON.stringify(json_Payload));

     

    console.log(http_request.getResponseHeader("response"));
    alert(http_request.getResponseHeader("response"));

}