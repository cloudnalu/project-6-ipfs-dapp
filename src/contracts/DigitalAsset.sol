// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

/// @title A simulator for trees
/// @author Larry A. Gardner
/// @notice You can use this contract for only the most basic simulation
/// @dev All function calls are currently implemented without side effects

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/payment/PullPayment.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


    /// @notice Calculate tree age in years, rounded up, for live trees
    /// @dev The Alexandr N. Tetearing algorithm could increase precision
    /// @notice The number of rings from dendrochronological sample
    /// @notice age in years, rounded up for passetial years

/// @notice provide token IDs for when item is purchased. 
/// @notice provide token ID for item when uploaded.
/// @notice create mapping with a key value of the item ID. Set mapping as private to not expose the ID. 
/// @notice if the item exists.
contract DigitalAsset is ERC721, PullPayment, Ownable {
    uint256 public _tokenIds; 
    uint256 public _assetItemIds; 
    mapping(uint256 => AssetItem) private _assetItems; 
    bool isActive = true; 
    address admin;

    struct AssetItem {
        address seller;
        uint256 price;
        string tokenURI;
        bool exists;
    }

    constructor() public ERC721("DigitalAsset", "ART") {
        admin = msg.sender;
    }

/// @notice check if item exists. If the fuction does not return the passed in item ID, then revert the call. 
/// @notice item ID or error
    modifier assetItemExist(uint256 id) { 
        require(_assetItems[id].exists, "Not Found");
        _;
    }

/// @notice seller invokes a public function for adding an item with a price and a tokenURI
/// @notice check if seller has given a price for the item
/// @notice create new item object with the item ID value and pass in the parameters
/// @notice increment item ID 
    function addAssetItem( uint256 price, string memory tokenURI) 
        public
        contractIsActive
    {
        require(price > 0, "Price cannot be 0"); 

        _assetItemIds++;  
        _assetItems[_assetItemIds] = AssetItem(msg.sender, price, tokenURI, true); 
    }

/// @notice users invoke a public function to get the items from the mapping with passed in ID. If an item object is found, unwrap it and return the data. 
/// @notice integers and string for the ID

    function getAssetItem(uint256 id)
        public
        view
        assetItemExist(id)
        returns (
            uint256,
            uint256,
            string memory
        )
    {
        AssetItem memory assetItem = _assetItems[id];
        return (id, assetItem.price, assetItem.tokenURI);
    }
/// @notice purchase item, passing in the price and item ID. Make public and payable to enable buyer to send ether to the function. 
/// @notice get the item object with the passed in item ID and check if exists, then check if the buyer has sent the required amount of ether.
/// @notice return the token ID, incremented as a new ID
/// @notice mint the image and pass the resulting token to the buyer
/// @notice set the token URI as the IPFS URL of the item
/// @notice call the pull payment contract to safely transfer and store the incoming payment to an escrow contract
/// @notice for the tranfer is the destination sellers address and the value
    function purchaseAssetItem(uint256 assetItemId)
        external
        payable
        contractIsActive
        assetItemExist(assetItemId)
    {
        AssetItem storage assetItem = _assetItems[assetItemId];

        require(msg.value >= assetItem.price, "Your bid is too low");

        _tokenIds++;

        _safeMint(msg.sender, _tokenIds);
        _setTokenURI(_tokenIds, assetItem.tokenURI);
        _asyncTransfer(assetItem.seller, msg.value);
    }
/// @notice allow the seller to get and withdraw the payments made in escrow to the contract 
    function getPayments() external {
        withdrawPayments(msg.sender);
    }

    
/// @notice allow the admin/owner of the contract to turn the availability of purchasing payments on or off
    function toggleCircuitBreaker() external {
        require(admin == msg.sender);
        isActive = !isActive;
    }
    modifier contractIsActive() {
        require(isActive == true);
        _;
    }


}