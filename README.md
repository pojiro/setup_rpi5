# Raspberry Pi 5 Ansible Setup

Raspberry Pi 5のセットアップを自動化するAnsible playbookです。

## 前提条件

1. Raspberry Pi OSがインストール済み
2. SSH接続が有効化されている
3. Ansibleがインストール済み（コントロールマシン）

## 初期設定

### 1. インベントリファイル設定

`inventory.yml`でRaspberry Pi 5のIPアドレスを設定してください：

```yaml
ansible_host: 192.168.1.100  # 実際のIPアドレスに変更
```

### 2. SSH鍵設定

SSH鍵認証を設定するか、パスワード認証を使用する場合は以下を追加：

```yaml
ansible_ssh_pass: your_password
```

## 使用方法

### SSH接続確認

```bash
ansible-playbook playbooks/ssh-check.yml
```

### 個別ホスト確認

```bash
ansible rpi5-01 -m ping
```

### システム情報取得

```bash
ansible rpi5 -m setup
```

## トラブルシューティング

- SSH接続エラー: IPアドレス、ユーザー名、SSH鍵を確認
- 権限エラー: sudoパスワードが必要な場合は `--ask-become-pass` オプションを使用
- Python未インストール: `ansible_python_interpreter` パスを確認
