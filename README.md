# How to hack smart contracts by exploiting behaviour of various non-standard tokens in the blockchain space
We explore the various ways a blackhat could attempt to steal funds via custom token implementations and hence what are the common pitfalls a blockchain developer should safeguard against.<br>
These are simplified examples so that one can better grasp the inner workings of such tokens. Exploits in the wild could very well be of greater complexity, but the principles remain the same.<br><br>

## How to run

### run all tests
`npx hardhat test --trace` <br>
*`'--trace'` flag is optional*
### run specific test
`npx hardhat test --trace --grep 01-BadTransfer_Token` <br>
