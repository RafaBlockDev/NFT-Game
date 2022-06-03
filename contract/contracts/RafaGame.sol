// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

/// @dev NFT Contract to inherit from
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

/// @dev Helper functions OpenZeppelin provides
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

import "./libraries/Base64.sol";

import "hardhat/console.sol";

/// @dev The contract inherits from ERC721, which is the standard NFT contractss
contract NFTGame is ERC721 {
    /// @dev The game will hold attributes in a struct
    struct CharacterAttributes {
        uint256 characterIndex;
        string name;
        string imageURI;
        uint256 hp;
        uint256 maxHp;
        uint256 attackDamage;
    }
    /// @dev Struct for the BigBoss
    struct BigBoss {
        string name;
        string imageURI;
        uint256 hp;
        uint256 maxHp;
        uint256 attackDamage;
    }

    BigBoss public bigBoss;

    /// @dev A lil array to help the user hold the default data for our characters.
    /// @notice This will be helpful when the user mint new characters and need to know
    // things like their HP, AD, etc.
    CharacterAttributes[] defaultCharacters;

    /// @dev The tokenId is the NFT´s unique identifier, it is just a number that goes
    // 0, 1, 2, 3, etc.
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // It can create a mapping from the nft´s tokenId => that NFT´s attributes.
    mapping(uint256 => CharacterAttributes) public nftHolderAttributes;

    // A mapping from an address => the NFT´s tokenId. Give me an ez way
    // to store the owner of the NFT and reference it later.
    mapping(address => uint256) public nftHolders;

    /// @dev Data passed in to the contract when it is first created initializing the characters
    constructor(
        string[] memory characterNames,
        string[] memory characterImageURIs,
        uint256[] memory characterHp,
        uint256[] memory characterAttackDmg,
        string memory bossName,
        string memory bossImageURI,
        uint256 bossHp,
        uint256 bossAttackDamage
    ) ERC721("HEROES", "HERO") {
        bigBoss = BigBoss({
            name: bossName,
            imageURI: bossImageURI,
            hp: bossHp,
            maxHp: bossHp,
            attackDamage: bossAttackDamage
        });

        console.log(
            "Done initializing boss %s w/ HP %s, img %s",
            bigBoss.name,
            bigBoss.hp,
            bigBoss.imageURI
        );

        for (uint256 i = 0; i < characterNames.length; i += 1) {
            defaultCharacters.push(
                CharacterAttributes({
                    characterIndex: i,
                    name: characterNames[i],
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
                c.hp,
                c.imageURI
            );
        }
        /// @dev It increment _tokenIds here so that the first NFT has an ID of 1
        _tokenIds.increment();
    }

    /// @notice Users would be able to hit this function and get their NFT based on the
    // characterId they send in!
    function mintCharacterNFT(uint256 _characterIndex) external {
        // Get current tokenId (starts at 1 since it incremented in the contructor)
        uint256 newItemId = _tokenIds.current();
        // The magical function! Assigns the tokenId to the caller´s wallet address.
        _safeMint(msg.sender, newItemId);

        // We map the tokenId => their character atttributes.
        nftHolderAttributes[newItemId] = CharacterAttributes({
            characterIndex: _characterIndex,
            name: defaultCharacters[_characterIndex].name,
            imageURI: defaultCharacters[_characterIndex].imageURI,
            hp: defaultCharacters[_characterIndex].hp,
            maxHp: defaultCharacters[_characterIndex].maxHp,
            attackDamage: defaultCharacters[_characterIndex].attackDamage
        });

        console.log(
            "Minted NFT w/ tokenId %s and characterIndex %s ",
            newItemId,
            _characterIndex
        );

        // Keep an easy way to see who owns what NFT
        nftHolders[msg.sender] = newItemId;

        // Increment the tokenIf for the next person that uses it.
        _tokenIds.increment();
    }

    function tokenURI(uint256 _tokenId)
        public
        view
        override
        returns (string memory)
    {
        /// @dev Return NFT data consulting _tokenID
        CharacterAttributes memory charAttributes = nftHolderAttributes[
            _tokenId
        ];
        /// @dev Convert uint256 to strings
        string memory strHp = Strings.toString(charAttributes.hp);
        string memory strMaxHp = Strings.toString(charAttributes.maxHp);
        string memory strAttackDamage = Strings.toString(
            charAttributes.attackDamage
        );

        string memory json = Base64.encode(
            abi.encodePacked(
                '{"name": "',
                charAttributes.name,
                " -- NFT #: ",
                Strings.toString(_tokenId),
                '", "description": "This is an NFT that lets people play in the game Metaverse Slayer!", "image": "',
                charAttributes.imageURI,
                '", "attributes": [ { "trait_type": "Health Points", "value": ',
                strHp,
                ', "max_value":',
                strMaxHp,
                '}, { "trait_type": "Attack Damage", "value": ',
                strAttackDamage,
                "} ]}"
            )
        );
        /// @notice Convert JSON and encode in Base64
        /// @dev Tell to the navigator: "Hey, I'm passing you a Base64 encoded JSON file, please render it properly"
        string memory output = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        return output;
    }

    function attackBoss() public {
        // Get the state of the player's NFT.
        uint256 nftTokenIdOfPlayer = nftHolders[msg.sender];
        // Make sure the player has more than 0 HP.
        CharacterAttributes storage player = nftHolderAttributes[
            nftTokenIdOfPlayer
        ];
        // Make sure the boss has more than 0 HP.
        console.log(
            "\nPlayer w/ character %s about to attack. Has %s HP and %s AD",
            player.name,
            player.hp,
            player.attackDamage
        );
        // Allow player to attack boss.
        console.log(
            "Boss %s has %s HP and %s AD",
            bigBoss.name,
            bigBoss.hp,
            bigBoss.attackDamage
        );

        require(player.hp > 0, "Error: Character must have HP to attack boss.");

        require(bigBoss.hp > 0, "Error: boss must have HP to attack boss.");
    }
}
