{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE ImportQualifiedPost #-}

module  Game.GameCompiler   where

import              Cardano.Api
import              Cardano.Api.Shelley             (PlutusScript (..))
import              Codec.Serialise                 (serialise)
import  qualified   Data.ByteString.Lazy    as  LBS
import  qualified   Data.ByteString.Short   as  SBS
import              Ledger
import              Ledger.Value

import              Game.ZeroOneGame
import              Game.GameTypes


writeValidator :: FilePath -> Ledger.Validator -> IO (Either (FileError ()) ())
writeValidator file = writeFileTextEnvelope @(PlutusScript PlutusScriptV1) file Nothing . PlutusScriptSerialised . SBS.toShort . LBS.toStrict . serialise . Ledger.unValidatorScript

{--------------------FIRST PLAYER CREDENTIALS--------------------}

firstPlayerPaymentPKH :: PaymentPubKeyHash
firstPlayerPaymentPKH = PaymentPubKeyHash "35ee0fbe05814abdb1507c27bc8f44acf1437201fa3695d4648c2d55"

firstPlayerStakePKH :: StakePubKeyHash
firstPlayerStakePKH = StakePubKeyHash "5820c7bec7d7ee3bda7b4add5ef67db239e3da796dbf541ed38f74a4576d57734d9f"

{----------------------------------------------------------------}

{-------------------SECOND PLAYER CREDENTIALS--------------------}

secondPlayerPaymentPKH :: PaymentPubKeyHash
secondPlayerPaymentPKH = PaymentPubKeyHash "eee71cbf8edd945a6fde32cd7d0d653a5646cf0f0ee335b5cc41239e"

secondPlayerStakePKH :: StakePubKeyHash
secondPlayerStakePKH = StakePubKeyHash "582014bdcfc92ae429400501536c7b37b61d54582035d1a6743170dd24e07a7646a2"

{----------------------------------------------------------------}

{--------------------------GAME DETAILS--------------------------}

gameBetAmount :: Integer
gameBetAmount = 30000000

gamePlayDeadline :: POSIXTime
gamePlayDeadline = 1679563980000

firstPlayerRevealDeadline :: POSIXTime
firstPlayerRevealDeadline = 1679563980000

{----------------------------------------------------------------}

{------------------------STATE NFT DETAILS-----------------------}

nftCurrencySymbol :: CurrencySymbol
nftCurrencySymbol = "7607a36b73a78d9654a3e201a38d7684eba1d956760cc5ab9506ec67"

nftTokenName :: TokenName
nftTokenName = "coconut"

{----------------------------------------------------------------}

writeZeroOneGameScript :: IO (Either (FileError ()) ())
writeZeroOneGameScript = writeValidator "output/ZeroOneGame.plutus" $ Game.ZeroOneGame.gameValidator $ GameParams
    { firstPlayerAddress   = pubKeyHashAddress firstPlayerPaymentPKH (Just firstPlayerStakePKH)
    , secondPlayerAddress  = pubKeyHashAddress secondPlayerPaymentPKH (Just secondPlayerStakePKH)
    , gBet                 = gameBetAmount
    , gPlayDeadline        = gamePlayDeadline
    , gRevealDeadline      = firstPlayerRevealDeadline
    , stateNFT             = AssetClass (nftCurrencySymbol, nftTokenName)
    }
