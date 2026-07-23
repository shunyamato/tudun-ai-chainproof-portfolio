# Tudun AI × ChainProof

> 日本語 / 中文 · Web3 Portfolio · Ethereum Sepolia Testnet

[🌐 Live Portfolio](https://shunyamato.github.io/tudun-ai-chainproof-portfolio/) · [🔎 Smart Contract on Sepolia Etherscan](https://sepolia.etherscan.io/address/0x0f4EDc46Ed426E893b01A75898859095cf7c1aEA) · [🧾 Latest registration transaction](https://sepolia.etherscan.io/tx/0xb835283838300c263e6bcb99f16110dd0de21a419b7abaefa3fddd58d809e0aa)

## 概要 / 项目概述

**Tudun AI × ChainProof** は、AI 画像・PDF・検査レポートなどのファイル完全性を、SHA-256 と Ethereum Sepolia 上のスマートコントラクトで検証する PoC です。  
**图盾 AI × ChainProof** 是一个通过 SHA-256 与 Ethereum Sepolia 智能合约验证图片、PDF 和检查报告文件完整性的概念验证项目。

ファイル本体をブロックチェーンへアップロードせず、ローカルで算出した SHA-256 をオンチェーン記録と照合します。  
文件本体不会上传到区块链；系统只将浏览器本地计算出的 SHA-256 与链上记录比对。

## できること / 已实现功能

1. **作成者による登録 / 创作者登记**  
   ファイルをブラウザ内で SHA-256 化し、MetaMask で確認した後に `registerProof(bytes32,string)` を Sepolia に送信します。登録時だけテスト ETH が必要です。  
   在浏览器内计算文件 SHA-256，经 MetaMask 确认后调用 `registerProof(bytes32,string)` 写入 Sepolia。只有登记时会使用测试 ETH。

2. **誰でもできる読み取り検証 / 任何人可做的只读验证**  
   同じファイルを選択すると、ブラウザ内で再計算した SHA-256 を `eth_call` で照会します。検証時はウォレット接続・署名・Gas が不要です。  
   选择同一文件后，浏览器会再次计算 SHA-256，并通过 `eth_call` 查询合约。验证不需要连接钱包、签名或 Gas。

3. **公開イベントの閲覧 / 公开事件记录浏览**  
   `ProofRegistered` イベントから、ハッシュ・登録タイプ・ウォレット・ブロック時刻・取引ハッシュを読み取ります。  
   从 `ProofRegistered` 事件读取哈希、登记类型、钱包、区块时间和交易哈希。

## 最新の実証 / 最新端到端实证

2026 年 7 月 23 日、以下の本物の閉ループを実行しました。  
2026 年 7 月 23 日，已完成以下真实的端到端闭环：

`MetaMask 登録 → Sepolia 確認 → 同一ファイルを第 9 項で読み取り検証 → PASS`

| 項目 / 项目 | 値 / 值 |
| --- | --- |
| Local test file / 本地测试文件 | `Tudun AI Phase 5 registration test.png` |
| Artifact type / 公开登记类型 | `Tudun AI Phase 5 registration test` |
| SHA-256 / On-chain key | `0x67BAA77B1CF18B61F031BEE7DF7C6C6998D0AD25DD66C9EB7295741F7EEBD081` |
| Network / 网络 | Ethereum Sepolia, Chain ID `11155111` |
| Contract / 合约 | [`0x0f4EDc46Ed426E893b01A75898859095cf7c1aEA`](https://sepolia.etherscan.io/address/0x0f4EDc46Ed426E893b01A75898859095cf7c1aEA) |
| Registrant / 登记钱包 | `0x3B674Dc9f2EDf5f2B53299Cc66F2fc3000125b4F` |
| Block timestamp / 区块时间 | `2026/07/23 17:51:48 JST` — source: Sepolia `block.timestamp` |
| Transaction / 交易 | [`0xb835283838300c263e6bcb99f16110dd0de21a419b7abaefa3fddd58d809e0aa`](https://sepolia.etherscan.io/tx/0xb835283838300c263e6bcb99f16110dd0de21a419b7abaefa3fddd58d809e0aa) |
| Result / 结果 | The same file was later selected in Section 9 and returned **PASS · Registered**. / 同一文件随后在第 9 项只读验证中返回 **PASS · 已登记**。 |

## 仕組み / 工作方式

1. ユーザーが PDF または画像を選択する。/ 用户选择 PDF 或图片。
2. ブラウザまたは FastAPI 原型がローカルで SHA-256 を計算する。/ 浏览器或 FastAPI 原型在本地计算 SHA-256。
3. 登録する場合、作成者が MetaMask でトランザクションを明示的に承認する。/ 登记时，创作者在 MetaMask 中明确确认交易。
4. 合約は SHA-256、登録タイプ、発行ウォレット、ブロック時刻を記録し、`ProofRegistered` を発行する。/ 合约记录 SHA-256、登记类型、发起钱包和区块时间，并发出 `ProofRegistered` 事件。
5. 検証する場合、`isRegistered` と `getProof` を読み取り専用で呼び出す。/ 验证时，只读调用 `isRegistered` 和 `getProof`。

## Smart Contract

- Network: **Ethereum Sepolia Testnet**
- Contract: [`ChainProofRegistry`](contracts/ChainProofRegistry.sol)
- Deployed address: [`0x0f4EDc46Ed426E893b01A75898859095cf7c1aEA`](https://sepolia.etherscan.io/address/0x0f4EDc46Ed426E893b01A75898859095cf7c1aEA)

| Function | Purpose / 用途 |
| --- | --- |
| `registerProof(bytes32 contentHash, string artifactType)` | Register one unique SHA-256 proof / 登记一个唯一 SHA-256 存证 |
| `isRegistered(bytes32 contentHash)` | Check whether a hash exists / 检查哈希是否已登记 |
| `getProof(bytes32 contentHash)` | Read issuer, block timestamp and type / 读取登记钱包、区块时间与类型 |

## 使用技術 / 技术栈

- Solidity `^0.8.20`
- Ethereum Sepolia Testnet
- MetaMask
- SHA-256 / Web Crypto API
- Browser JSON-RPC: `eth_call`, `eth_getLogs`
- Python / FastAPI local prototype
- HTML / CSS / GitHub Pages portfolio

## プライバシーと境界 / 隐私与边界

- 原ファイルとファイル名はブロックチェーンに保存しません。/ 原始文件与文件名不会写入区块链。
- 公開されるのは SHA-256、登録タイプ、ウォレット、ブロック時刻、取引ハッシュです。/ 公开的是 SHA-256、登记类型、钱包、区块时间和交易哈希。
- 登録タイプは公開文字列なので、個人情報や機密情報を書かないでください。/ 登记类型是公开字符串，请勿填写个人信息或机密内容。
- この記録はファイル完全性に関する技術的な証跡であり、著作権・創作性・法的権利を単独で証明するものではありません。/ 此记录是文件完整性的技术证据，不能单独证明著作权、原创性或法律权利。

## このリポジトリについて / 关于此仓库

GitHub Pages は**静的な作品集・ケーススタディ**です。GitHub Pages 上で実際のファイル登録サービスを動かしているわけではありません。  
GitHub Pages 是**静态作品集与案例说明页面**，不是在线文件登记服务。

実際にファイル選択、MetaMask 登録、読み取り検証を行うのは、開発中の **local FastAPI prototype** です。  
真正执行选文件、MetaMask 登记和只读验证的是正在开发中的 **本地 FastAPI 原型**。

## Next / 下一步

- Better error handling and multi-RPC fallback / 改善错误提示与多 RPC 备用
- Contract verification and deployment documentation / 合约验证与部署文档
- User-facing bilingual onboarding / 面向用户的中日双语操作引导
- Product interviews with artists, studios and cross-border creative teams / 与创作者、工作室和跨境团队进行产品访谈
