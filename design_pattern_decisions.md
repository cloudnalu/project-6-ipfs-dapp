I used the require statement to fail early and fail loud, before executing
I used a circuit breaker pattern to give the admin (contract deployer) the ability to stop the buyers from purchasing an asset item. 
Instead of sending eth directly to the seller, I used the pull over push payment “best practice” policy. This way the contract is protected from the reentrancy attack since the contract is not immediately pushing payments directly to users, instead, the user elects to click a button and call the withdraw function. 
