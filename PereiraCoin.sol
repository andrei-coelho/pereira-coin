//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import './OwnerContract.sol';
import './Market.sol';

contract PereiraCoin is Owner, Market {

    mapping(address => uint) wallets;

    uint amount             = 10000000;
    uint initial_cost_value = 1000;
    uint tax_to_market      = 50000;
    uint buy_in_coins       = 50000;

    function sendMeCoin(uint _amount) public onlyOwner {
        
        require(_amount <= amount);
        wallets[owner] = _amount;
        amount -= _amount;
    
    }

    function registerOnMarket() public payable {
        
        uint min_value = tax_to_market + (buy_in_coins * initial_cost_value);
        require (msg.value >= min_value, "tax to enter the market is higher");
        
        uint quant_coins = (msg.value - tax_to_market) / initial_cost_value;
        amount -= quant_coins;
        wallets[msg.sender] += quant_coins;
        
        register();
    }

    function buyCoins() public payable onlyExchangers {
        
        uint _amount = msg.value / initial_cost_value;
        require(_amount <= amount);
        
        amount -= _amount;
        wallets[msg.sender] += _amount;

    }

    function sellCoins(uint _amount, address _wallet) public onlyExchangers {
        
        if(exchangerIsBlocked()){
            require(wallets[msg.sender] - _amount >= 10000, "U cant sell this ammount");
        } else {
            require(wallets[msg.sender] >= _amount, "U cant sell this ammount");
        }
        
        wallets[msg.sender] -= _amount;
        wallets[_wallet]    += _amount;

    }

    function transfer(uint _amount, address _wallet) public {
        
        require(_amount <= wallets[msg.sender], "U cant transfer this amount");
        
        wallets[msg.sender] -= _amount;
        wallets[_wallet]    += _amount;
    
    }

}