//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Market {

    struct Exchanger {
        bool active;
        uint block_days_limit;   
    }

    mapping(address => Exchanger) exchangers;

    function register() internal {
        // exchanger can sell all coins after 1 year
        exchangers[msg.sender] = Exchanger(true, (block.timestamp + 365 days));
    }

    modifier onlyExchangers(){
        require(exchangers[msg.sender].active, "Ur not exchanger");
        _;
    }

    function exchangerIsBlocked() internal view returns(bool){
        return exchangers[msg.sender].block_days_limit < block.timestamp;
    }


}