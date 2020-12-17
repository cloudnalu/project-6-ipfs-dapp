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
If your receiving a CORS error in your console, configure the API
$ ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["http://localhost:3000", "http://127.0.0.1:5001", "https://webui.ipfs.io"]'
$ ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "POST"]'
You can deploy the contract to the Rinkeby testnet, but need to reconfigure IPFS to connect to infura instead of your locally running node. You can reconfigure by editing the IPFS client plugin config file. You also need Rinkeby testETH
Truffle migrate --network rinkeby
Connect to the project using the connect button via ethers.js
