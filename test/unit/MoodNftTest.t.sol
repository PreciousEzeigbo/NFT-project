// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import {MoodNft} from "../../src/MoodNft.sol";
import {Test, console} from "forge-std/Test.sol";

contract TestMoodNft is Test {
    MoodNft moodNft;
    string public constant HAPPY_SVG_URI =
        "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxjaXJjbGUgY3g9IjEwMCIgY3k9IjEwMCIgcj0iODAiIGZpbGw9IiNGRkQ3MDAiIHN0cm9rZT0iYmxhY2siIHN0cm9rZS13aWR0aD0iNCIgLz4KCiAgICA8Y2lyY2xlIGN4PSI3MCIgY3k9IjgwIiByPSIxMCIgZmlsbD0iYmxhY2siIC8+CgogICAgPGNpcmNsZSBjeD0iMTMwIiBjeT0iODAiIHI9IjEwIiBmaWxsPSJibGFjayIgLz4KCiAgICA8cGF0aCBkPSJNIDYwIDEyMCBRIDEwMCAxNjAgMTQwIDEyMCIgc3Ryb2tlPSJibGFjayIgc3Ryb2tlLXdpZHRoPSI0IiBmaWxsPSJub25lIiAvPgo8L3N2Zz4=";
    string public constant SAD_SVG_URI =
        "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxjaXJjbGUgY3g9IjEwMCIgY3k9IjEwMCIgcj0iODAiIGZpbGw9IiM4N0NFRUIiIHN0cm9rZT0iYmxhY2siIHN0cm9rZS13aWR0aD0iNCIgLz4KCiAgICA8Y2lyY2xlIGN4PSI3MCIgY3k9IjgwIiByPSIxMCIgZmlsbD0iYmxhY2siIC8+CgogICAgPGNpcmNsZSBjeD0iMTMwIiBjeT0iODAiIHI9IjEwIiBmaWxsPSJibGFjayIgLz4KCiAgICA8cGF0aCBkPSJNIDYwIDE0MCBRIDEwMCAxMDAgMTQwIDE0MCIgc3Ryb2tlPSJibGFjayIgc3Ryb2tlLXdpZHRoPSI0IiBmaWxsPSJub25lIiAvPgo8L3N2Zz4=";

    address USER = makeAddr("user");

    function setUp() public {
        moodNft = new MoodNft(SAD_SVG_URI, HAPPY_SVG_URI);
    }

    function testViewTokenURI() public {
        vm.prank(USER);
        moodNft.mintNft();
        console.log(moodNft.tokenURI(0));
    }
}
