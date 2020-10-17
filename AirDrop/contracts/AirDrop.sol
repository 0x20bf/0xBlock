pragma solidity ^0.5.2;
import "./utils/COwnable.sol"; 
import "./utils/IERC20.sol"; 

/**
 * @title AirDrop
 * @dev Airdrop program. https://github.com/0x20bf/0xBlock
 */

contract AirDrop is COwnable {
    mapping (address => uint256) public whitelist;
    address public token_address;
    uint256 private _decimals;

    constructor(address token, uint256 decimals) public{ 
        token_address = token;
        _decimals = decimals;
    }

    function redeem() public returns(bool res) {
        require (whitelist[msg.sender] > 0 );
        IERC20 token = IERC20(token_address);
        token.transfer(msg.sender, whitelist[msg.sender]);
        whitelist[msg.sender] = 0;
        return true;
    }

    function setWhitelist(address[] memory accounts, uint256[] memory amounts) public onlyOwner() returns(bool res) {
        require (accounts.length == amounts.length);
        for(uint256 i=0; i<accounts.length; i++){
            if (accounts[i]!=address(0)){
                whitelist[accounts[i]] = amounts[i]*(10**_decimals);
            }
        }
        return true;
    }
    
    function withdraw(address token_addr) public onlyOwner() returns(bool res) {
        IERC20 token = IERC20(token_addr);
        token.transfer(msg.sender, token.balanceOf(address(this)));
        return true;
    }
    
    function kill() public onlyOwner() {
        address payable addr = address(uint160(owner()));
        selfdestruct(addr);
    }

}
