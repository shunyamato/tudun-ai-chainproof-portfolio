# Tudun AI × ChainProof

> 日本語 / 中文 · Web3 Portfolio · Sepolia Testnet

[🌐 Live Portfolio](https://shunyamato.github.io/tudun-ai-chainproof-portfolio/) · [🔎 Smart Contract on Sepolia Etherscan](https://sepolia.etherscan.io/address/0x0f4EDc46Ed426E893b01A75898859095cf7c1aEA)

## 概要 / 项目概述

**Tudun AI × ChainProof** は、AI画像・PDF・検査レポートなどのファイル完全性を、SHA-256 と Ethereum Sepolia 上のスマートコントラクトで検証する PoC です。  
**图盾 AI × ChainProof** 是一个通过 SHA-256 与 Ethereum Sepolia 智能合约验证图片、PDF 和检测报告文件完整性的概念验证项目。

ファイル本体をブロックチェーンへアップロードせず、ハッシュ値のみをオンチェーン記録と照合します。  
文件本身不会上传到区块链，仅将其哈希值与链上登记记录进行比对。

## 解決する課題 / 解决的问题

AI画像、PDF、検査レポートは複製や軽微な編集が容易です。そのため、現在のファイルが登録済みの元ファイルと完全に同一かを迅速に判断しにくい課題があります。  
AI 图片、PDF 或检测报告很容易被复制或轻微修改，因此难以快速判断当前文件是否与已登记的原始文件完全一致。

本プロジェクトでは、ファイルの SHA-256 を使って完全一致のみを検証します。  
本项目使用文件 SHA-256，仅在文件字节完全一致时判定为已登记。

## 検証デモ / 验证演示

| ファイル / 文件 | 結果 / 结果 |
| --- | --- |
| `test-report.pdf`（原ファイル / 原始文件） | `PASS · Registered` |
| `test-report - 副本.pdf`（変更コピー / 修改副本） | `FAIL · Not registered` |

同じファイルはオンチェーン登録と一致し、1バイトでも変更されると SHA-256 が変化して未登録として扱われます。  
相同文件会与链上登记一致；即使只修改一个字节，SHA-256 也会变化，因此会显示为未登记。

## 仕組み / 工作方式

1. ユーザーが PDF または画像を選択する。  
   用户选择 PDF 或图片。

2. FastAPI / Python がファイルの SHA-256 を計算する。  
   FastAPI / Python 计算文件的 SHA-256。

3. Sepolia 上の `ChainProofRegistry` に対して読み取り専用で照会する。  
   通过只读调用查询 Sepolia 上的 `ChainProofRegistry`。

4. 登録済みの場合は、登録ウォレット・登録時刻・種類を返す。  
   如果已登记，则返回登记钱包、登记时间和文件类型。

## Smart Contract

- **Network:** Ethereum Sepolia Testnet
- **Contract:** [`ChainProofRegistry`](https://sepolia.etherscan.io/address/0x0f4EDc46Ed426E893b01A75898859095cf7c1aEA)
- **Address:** `0x0f4EDc46Ed426E893b01A75898859095cf7c1aEA`

主な関数 / 主要函数：

- `registerProof(bytes32 contentHash, string artifactType)`
- `isRegistered(bytes32 contentHash)`
- `getProof(bytes32 contentHash)`

## 使用技術 / 技术栈

| 領域 / 领域 | 技術 / 技术 |
| --- | --- |
| Smart Contract | Solidity `^0.8.20` |
| Blockchain | Ethereum Sepolia Testnet |
| Wallet | MetaMask |
| Backend | Python / FastAPI |
| File Integrity | SHA-256 |
| Read-only Verification | `eth_call` |
| Portfolio | HTML / CSS / GitHub Pages |

## プライバシーと技術上の境界 / 隐私与技术边界

- 元ファイルはブロックチェーンに保存しません。  
  原始文件不会存储到区块链。

- 検証時はウォレット接続・署名・Gas 消費を行いません。  
  验证时不连接钱包、不签名、不消耗 Gas。

- 登録時のみ、ユーザーが MetaMask で明示的にトランザクションを承認します。  
  仅在登记时由用户通过 MetaMask 明确确认交易。

- 本機能はファイル完全性を示す技術的な記録であり、著作権・創作性・法的権利を単独で証明するものではありません。  
  本功能提供的是文件完整性的技术记录，并不能单独证明著作权、原创性或法律权利。

## リポジトリについて / 关于此仓库

このリポジトリは、設計・実装内容・検証結果を公開するための静的ポートフォリオです。  
本仓库是用于展示项目设计、实现内容和验证结果的静态作品集。

実際の FastAPI ローカルアプリケーションは、ファイル検証機能を備えたプロトタイプとして開発しています。  
实际的 FastAPI 本地应用正在作为具备文件验证功能的原型持续开发。

## Author

GitHub: [@shunyamato](https://github.com/shunyamato)
