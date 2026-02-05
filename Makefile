# Raspberry Pi 5 Ansible管理用Makefile

.PHONY: ping ssh-check setup install clean

# SSH接続確認
ping:
	ansible rpi5 -m ping

# 個別ホスト確認
ping-00:
	ansible rpi5-00 -m ping

ping-01:
	ansible rpi5-01 -m ping

ping-02:
	ansible rpi5-02 -m ping

# 詳細なSSH接続確認
ssh-check:
	ansible-playbook playbooks/ssh-check.yml

# システム情報取得
info:
	ansible rpi5 -m setup

# 構文チェック
syntax-check:
	ansible-playbook --syntax-check playbooks/ssh-check.yml

# 自動アップデート無効化
disable-auto-update:
	ansible-playbook playbooks/disable-auto-update.yml

# 自動アップデート無効化（ドライラン）
disable-auto-update-dry:
	ansible-playbook --check playbooks/disable-auto-update.yml

# 静的IP設定
setup-static-ip:
	ansible-playbook playbooks/setup-static-ip.yml

# 静的IP設定（ドライラン）
setup-static-ip-dry:
	ansible-playbook --check playbooks/setup-static-ip.yml

# Docker インストール
install-docker:
	ansible-playbook playbooks/install-docker.yml

# Docker インストール（ドライラン）
install-docker-dry:
	ansible-playbook --check playbooks/install-docker.yml

# zenoh バイナリインストール
install-zenoh:
	ansible-playbook playbooks/install-zenoh.yml

# zenoh バイナリインストール（ドライラン）
install-zenoh-dry:
	ansible-playbook --check playbooks/install-zenoh.yml

# ドライラン
dry-run:
	ansible-playbook --check playbooks/ssh-check.yml

# 詳細出力で実行
verbose:
	ansible-playbook -vvv playbooks/ssh-check.yml

# インベントリ確認
inventory:
	ansible-inventory --list

# ヘルプ
help:
	@echo "利用可能なコマンド:"
	@echo "  make ping        - 基本的なSSH接続確認（全台）"
	@echo "  make ping-00     - rpi5-00のSSH接続確認"
	@echo "  make ping-01     - rpi5-01のSSH接続確認"
	@echo "  make ping-02     - rpi5-02のSSH接続確認"
	@echo "  make ssh-check   - 詳細なSSH接続確認とシステム情報取得"
	@echo "  make info        - システム情報のみ取得"
	@echo "  make syntax-check - playbook構文チェック"
	@echo "  make dry-run     - ドライラン実行"
	@echo "  make verbose     - 詳細出力で実行"
	@echo "  make disable-auto-update     - 自動アップデート無効化"
	@echo "  make disable-auto-update-dry - 自動アップデート無効化（ドライラン）"
	@echo "  make setup-static-ip         - eth0静的IP設定"
	@echo "  make setup-static-ip-dry     - eth0静的IP設定（ドライラン）"
	@echo "  make install-docker          - Docker インストール"
	@echo "  make install-docker-dry      - Docker インストール（ドライラン）"
	@echo "  make install-zenoh           - zenoh バイナリインストール"
	@echo "  make install-zenoh-dry       - zenoh バイナリインストール（ドライラン）"
