// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity ^0.8.20;

import {ERC20,IERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

error TippingFailureError(address tipper);

contract FakeDrunk is ERC20Burnable, ReentrancyGuard, Ownable {

    event Tip(address indexed sender, address indexed author, uint amount);
    /*//////////////////////////////////////////////////////////////
                                 CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/
    constructor(address owner, string memory name, string memory symbol) ERC20(name, symbol) Ownable(owner) {}

    /*///////////////////////////////////////////////////////////////
                                 PUBLIC
    //////////////////////////////////////////////////////////////*/
    function mint(address _account, uint256 _amount) public onlyOwner {
        _mint(_account, _amount);
    }

    function tip(address _host, uint256 amount) external payable nonReentrant {  
         (bool sent,) = _host.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
        emit Tip(msg.sender, _host, amount);
        IERC20(this).transferFrom(msg.sender, _host, amount);
    }
}
