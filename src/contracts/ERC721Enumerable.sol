// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';
import './interfaces/IERC721Enumerable.sol';

contract ERC721Enumerable is ERC721, IERC721Enumerable {

    uint256[] private _allTokens;

    // mapping from token id to position in all token array
        mapping(uint256 => uint256) private _allTokensIndex;

    // mapping of owner to the list of all owner token ids
        mapping(address => uint256[]) private _ownedTokens;

    // mapping from tokenid index of the owner token list
        mapping(uint256 => uint256) private _ownedTokensIndex;
    
    function _mint(address to, uint256 tokenId) internal override(ERC721) {
        super._mint(to, tokenId);
        // 2 things! A. add tokens to the owner
        // B. all tokens to our total supply

        _addTokensToAllTokenEnumeration(tokenId);
        _addTokensToOwnerEnumeration(to, tokenId);
    }
    
    // add tokens to the _alltokens array and a set the position of the token indexes
    function _addTokensToAllTokenEnumeration(uint256 tokenId) private {
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    function _addTokensToOwnerEnumeration(address to,uint256 tokenId) private {
        //
        // 1. add address and token id to the _ownedTokens
        // 2. ownedTokensIndex tokenId set to address of ownedTokens position
        // 3. we want to  execute this function with minting
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
    }

    constructor() {
        _registerInterface(bytes4(keccak256('totalSupply(bytes4)')^
        keccak256('tokenByIndex(bytes4)')^
        keccak256('tokenOfOwnerByIndex(bytes4)')));
    }


    // two function - one that returns tokenByIndex
    // another one that returns tokenOfOwnerByIndex

    function tokenByIndex(uint256 index) public override view returns(uint256) {
        // make sure that the index is not out of bounds of the 
        // total supply
        require(index < totalSupply(), 'global index is out of bounds!');
        return _allTokens[index];
    }

    function tokenOfOwnerByIndex(address owner, uint index) public override view returns(uint256) {
        require(index < balanceOf(owner),'owner index is out of bounds!');
        return _ownedTokens[owner][index];
    }

    // return the total supply of the _allTokens array
    function totalSupply() public override view returns(uint256) {
        return _allTokens.length;
    }
}