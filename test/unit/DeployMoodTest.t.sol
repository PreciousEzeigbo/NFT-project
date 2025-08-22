// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";
import {Test, console} from "forge-std/Test.sol";

contract TestDeployMoodNft is Test {
    DeployMoodNft public deployer;

    function setUp() public {
        deployer = new DeployMoodNft();
    }

    function testConvertSvgToImageURI() public view {
        string
            memory expectedUri = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdodD0iNTAwIj4gPHRleHQgeD0iMCIgeT0iMTUiIGZpbGw9ImJsYWNrIj4gaGkhIEkgZGVjb2RlZCB0aGlzISA8L3RleHQ+IDwvc3ZnPg==";
        string
            memory svg = '<svg xmlns="http://www.w3.org/2000/svg" width="500" height="500"> <text x="0" y="15" fill="black"> hi! I decoded this! </text> </svg>';
        string memory actualUri = deployer.svgToImageURI(svg);
        assert(
            keccak256(abi.encodePacked(actualUri)) ==
                keccak256(abi.encodePacked(expectedUri))
        );
    }
}
