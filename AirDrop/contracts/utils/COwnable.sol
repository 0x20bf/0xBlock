pragma solidity ^0.5.0;

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract COwnable {
    address private __owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev The Ownable constructor sets the original `owner` of the contract to the sender
     * account.
     */
    constructor () internal {
        __owner = msg.sender;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_isOwner());
        _;
    }

    /**
     * @return the address of the owner.
     */
    function owner() public view returns (address) {
        return __owner;
    }

    /**
     * @dev Allows the current owner to transfer control of the contract to a newOwner.
     * @param newOwner The address to transfer ownership to.
     */
    function transferOwnership(address newOwner) public onlyOwner() {
        _transferOwnership(newOwner);
    }

    /**
     * @dev Allows the current owner to relinquish control of the contract.
     * @notice Renouncing to ownership will leave the contract without an owner.
     * It will not be possible to call the functions with the `onlyOwner`
     * modifier anymore.
     */
     /*
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(__owner, address(0));
        __owner = address(0);
    }
    */
    

    /**
     * @return true if `msg.sender` is the owner of the contract.
     */
    function _isOwner() internal view returns (bool) {
        return msg.sender == __owner;
    }

    

    /**
     * @dev Transfers control of the contract to a newOwner.
     * @param newOwner The address to transfer ownership to.
     */
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0));
        emit OwnershipTransferred(__owner, newOwner);
        __owner = newOwner;
    }
}
