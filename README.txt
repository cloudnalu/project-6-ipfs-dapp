README

This is a dapp for buyers and sellers of an image asset. 

Buyer user story: 
	A Buyer can connect to the app, view items available for sale, and purchase items. Their purchased items are then displayed in their purchased items history. 

Seller user story: 
	A Seller can connect to the app, define a price for an item, and upload an image of the item. When an item is sold, it is held in escrow, until the Seller checks for payments and withdraws them using the buttons. 

The admin of the app can connect and use the Open/Close store button to toggle the purchasing function on or off. 

The image files are stored with IPFS (Interplanetary File System). 
The project is deployed on the Rinkeby testnet. 
The front-end web application may be hosted on localhost:3000. 

To run the project:

Dependencies:
Node (I used v14.9.0)
Ganache
Truffle
IPFS Client
Metamask or web3 wallet provider

Clone the project from github
Install the dependencies with $npm install
Start Ganache
Copy mnemonic from Ganache
Create a .env file from the exampledotenv file and paste in the mnemonic in quotes
$ truffle migrate --reset
If you’re having trouble compiling/migrating the contracts, delete the abis folder and recompile/migrate. 
$ NPM run serve to open the front-end application
$ IPFS daemon
Check that IPFS is running by going to http://127.0.0.1:5001/webui
The front end app also needs to be running on localhost:3000.
If your receiving a CORS error in your console after npm serve, configure the API.

The contract is deployed to Rinkeby testnet. You could redeploy it using command truffle migrate --network rinkeby
Connect to the project using the connect button via ethers.js
