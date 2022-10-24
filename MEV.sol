//SPDX-License-Identifier: Unlicense
pragma solidity 0.8.17;

contract MEV {
    struct Adjustment {
        uint256 adjustment0,
        uint256 adjustment1,
        uint256 adjustmentToken0
    }

function getOrderedReserves(
    address pool0_,
    address pool1_,
    Adjustments memory adjustment_,
    bool baseTokenSmaller_
)
    internal
    view
    returns(
        address lowerPool,
        address higherPool,
        OrderedReserves memory orderedReserves
    )
{
    (uint256 pool0Reserve0, uint256 pool0Reserve1, ) = IUniswapV2Pair(pool0_).getReserves();
    (uint256 pool1Reserve0, uint256 pool1Reserve1, ) = IUniswapV2Pair(pool1_).getReserves();

    if(pool0_ == adjustment_.adjustmentPool) {
        if(adjustment_.adjustmentToken0 == IUniswapV2Pair(pool0_).token0()) {
            pool0Reserve0 -= adjustment_.adjustment0;
            pool0Reserve1 += adjustment_.adjustment1;
        } else {
            pool0Reserve1 -= adjustment_.adjustment0;
            pool0Reserve0 += adjustment_.adjustment1;            
        }
    } else {
        if(adjustment_.adjustmentToken0 == IUniswapV2Pair(pool1_).token0()) {
            pool1Reserve0 -= adjustment_.adjustment0;
            pool1Reserve1 += adjustment_.adjustment1;
        } else {
            pool1Reserve1 -= adjustment_.adjustment0;
            pool1Reserve0 += adjustment_.adjustment1;            
        }        
      }
   }
}