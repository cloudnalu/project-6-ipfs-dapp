
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
Node (I used 14.9.0)
Ganache
Truffle
IPFS Client

1. Clone the project from github
2. Install the dependencies with $npm install
3. Start Ganache
4. $ truffle migrate --reset
5. $ NPM run serve to open the front-end application
6. $ IPFS daemon
7. Check that IPFS is running by going to http://127.0.0.1:5001/webui
8. If your receiving a CORS error in your console, edit your IPFS configuration in the console by running $ ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "POST"]'Liams-MacBook-Pro:nft-digital-markeipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "POST"]'
9. You can deploy the contract to the Rinkeby testnet, but need to reconfigure IPFS to connect to infura instead of your locally running node. You can reconfigure by editing the IPFS client plugin config file. You also need Rinkeby testETH
10. Truffle migrate --network rinkeby
11. Connect to the project using the connect button using web3 via ethers.js and interact with the app

