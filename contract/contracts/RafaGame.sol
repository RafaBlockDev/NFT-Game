// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract NFTGame {
    /// @dev The game will hold attributes in a struct
    struct CharacterAttributes {
        uint256 characterIndex;
        string name;
        string description;
        string imageURI;
        uint256 hp;
        uint256 maxHp;
        uint256 attackDamage;
    }
    /// @dev A lil array to help the user hold the default data for our characters.
    /// @notice This will be helpful when the user mint new characters and need to know
    // things like their HP, AD, etc.
    CharacterAttributes[] defaultCharacters;

    /// @dev Data passed in to the contract when it is first created initializing the characters
    constructor(
        string[] memory characterNames,
        string[] memory characterDescription,
        string[] memory characterImageURIs,
        uint256[] memory characterHp,
        uint256[] memory characterAttackDmg
    ) {
        for (uint256 i = 0; i < characterNames.length; i += 1) {
            defaultCharacters.push(
                CharacterAttributes({
                    characterIndex: i,
                    name: characterNames[i],
                    description: characterDescription[i],
                    imageURI: characterImageURIs[i],
                    hp: characterHp[i],
                    maxHp: characterHp[i],
                    attackDamage: characterAttackDmg[i]
                })
            );

            CharacterAttributes memory c = defaultCharacters[i];
            console.log(
                "Done initializing %s w/ HP %s, img %s ",
                c.name,
                c.description,
                c.hp,
                c.imageURI
            );
        }
    }
}
