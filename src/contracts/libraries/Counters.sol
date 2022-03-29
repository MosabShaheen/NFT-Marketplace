// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import './SafeMath.sol';

library Counters {
    using SafeMath for uint256;

    struct Counter{
        uint256 _value;
    }

    //we want to find the current value of a count
    function current(Counter storage counter) internal view returns(uint256) {
        return counter._value;
    }
    function decrement(Counter storage counter) internal {
        counter._value = counter._value.sub(1);
    }
    function increment(Counter storage counter) internal {
        counter._value += 1;
    }
}

// build your own variable type with the keyword 'struct'

