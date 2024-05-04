
import "forge-std/Script.sol";
import "forge-std/Vm.sol";

import "@openzeppelin/contracts/utils/Create2.sol";
import "../contracts/token/FakeDrunk.sol";
library LibDeploy {

    bytes32 public constant SALT = keccak256(bytes("DrunkProtocolV1"));
    function deploy2(bytes memory code, bytes32 salt) public returns (address) {
        address addr;
        require(code.length != 0, "Create2: bytecode length is zero");
        assembly {
            addr := create2(0, add(code, 0x20), mload(code), salt)
            if iszero(extcodesize(addr)) { revert(0, 0) }
        }
        return addr;
    }

    function deployFakeDrunk() internal returns (address addr) {
        addr = deploy2(
            abi.encodePacked(
                type(FakeDrunk).creationCode,
                abi.encode(
                    address(0xBE64E5a432b6595621cD3c17314E5d613cba470f),
                    "DRUNK Token",
                    "DRUNK"
                )
            ),
            SALT
        );

        console.logBytes(
            abi.encodePacked(
                abi.encode(
                    address(0xBE64E5a432b6595621cD3c17314E5d613cba470f),
                    "DRUNK Token",
                    "DRUNK"
                )
            )
        );
    }



}