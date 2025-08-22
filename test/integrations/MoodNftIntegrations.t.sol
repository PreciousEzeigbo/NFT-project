// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "../../src/MoodNft.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";

contract MoodNftIntegrationTest is Test {
    MoodNft moodNft;
    string public constant HAPPY_SVG_URI =
        "data: image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxjaXJjbGUgY3g9IjEwMCIgY3k9IjEwMCIgcj0iODAiIGZpbGw9IiNGRkQ3MDAiIHN0cm9rZT0iYmxhY2siIHN0cm9rZS13aWR0aD0iNCIgLz4KCiAgICA8Y2lyY2xlIGN4PSI3MCIgY3k9IjgwIiByPSIxMCIgZmlsbD0iYmxhY2siIC8+CgogICAgPGNpcmNsZSBjeD0iMTMwIiBjeT0iODAiIHI9IjEwIiBmaWxsPSJibGFjayIgLz4KCiAgICA8cGF0aCBkPSJNIDYwIDEyMCBRIDEwMCAxNjAgMTQwIDEyMCIgc3Ryb2tlPSJibGFjayIgc3Ryb2tlLXdpZHRoPSI0IiBmaWxsPSJub25lIiAvPgo8L3N2Zz4=";
    string public constant SAD_SVG_URI =
        "data: image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxjaXJjbGUgY3g9IjEwMCIgY3k9IjEwMCIgcj0iODAiIGZpbGw9IiM4N0NFRUIiIHN0cm9rZT0iYmxhY2siIHN0cm9rZS13aWR0aD0iNCIgLz4KCiAgICA8Y2lyY2xlIGN4PSI3MCIgY3k9IjgwIiByPSIxMCIgZmlsbD0iYmxhY2siIC8+CgogICAgPGNpcmNsZSBjeD0iMTMwIiBjeT0iODAiIHI9IjEwIiBmaWxsPSJibGFjayIgLz4KCiAgICA8cGF0aCBkPSJNIDYwIDE0MCBRIDEwMCAxMDAgMTQwIDE0MCIgc3Ryb2tlPSJibGFjayIgc3Ryb2tlLXdpZHRoPSI0IiBmaWxsPSJub25lIiAvPgo8L3N2Zz4=";

    DeployMoodNft deployer;

    address USER = makeAddr("user");

    function setUp() public {
        deployer = new DeployMoodNft();
        moodNft = deployer.run();
    }

    function testViewTokenURIIntegration() public {
        vm.prank(USER);
        moodNft.mintNft();
        console.log(moodNft.tokenURI(0));
    }

    function testFlipTokenToSad() public {
        vm.prank(USER);
        moodNft.mintNft();

        // Get initial token URI (should be HAPPY)
        string memory initialTokenURI = moodNft.tokenURI(0);

        vm.prank(USER);
        moodNft.flipMood(0);

        // Get token URI after flip (should be SAD)
        string memory flippedTokenURI = moodNft.tokenURI(0);

        // The URIs should be different after flipping
        assert(
            keccak256(abi.encodePacked(initialTokenURI)) !=
                keccak256(abi.encodePacked(flippedTokenURI))
        );
    }
}
