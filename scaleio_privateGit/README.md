README scaleio_7.x
===============

[TOC]

### 00 前提条件
+ 本ansibleでは**6台を1セット**としてScaleIO構築を行います。
+ 6台それぞれで使用する**ストレージデバイスの数、サイズは共通**とします
+ 実行手順は以下を参照して下さい

### 01 インベントリ変更
+ `inv.ini`に対象の6台のIPアドレスを記載して下さい
記載例
```bash
[all]
192.168.33.15
192.168.33.16
192.168.33.17
192.168.33.18
192.168.33.19
192.168.33.20
```

### 02 変数定義変更
+ `roles/scaleio/vars/main.yml `の変数定義を適宜変更して下さい
+ 以下の`cluster`、`nodes`、`devices`が都度変更となります。
(nodesやdevicesは構成に合わせて行を追加して下さい)
記載例
```bash
cluster:
  env: prd
  pd_name: kc2s-h-07-001
  pool_name: ssd-pool
  mdm1_ip: 192.168.33.15
  mdm2_ip: 192.168.33.16
  tb_ip: 192.168.33.17
  sds1_ip: 192.168.33.15
  sds2_ip: 192.168.33.16
  stock_ip: 192.168.33.17
nodes:
 - { ip: "{{ cluster.mdm1_ip }}" , fs: fs01 }
 - { ip: "{{ cluster.mdm2_ip }}" , fs: fs02 }
 - { ip: "{{ cluster.tb_ip }}"   , fs: fs03 }
devices:
 - device: "/dev/sdb"
 - device: "/dev/sdc"
 - device: "/dev/sdd"
 - device: "/dev/sde"
 - device: "/dev/sdf"
 - device: "/dev/sdg"
```
### 03 ansible-playbook
+ プレイブックを実行します
```bash
ansible-playbook -i inv.ini site.yml -vvv
```

### 04 確認
+ 今後追記(自動化予定)

### (appendix) tree構造
.
├── README.md
├── inv.ini
├── remove.yml
├── roles
│   └── scaleio
│       ├── defaults
│       ├── files
│       │   ├── EMC-ScaleIO-callhome-1.32-402.1.el7.x86_64.rpm
│       │   ├── EMC-ScaleIO-gateway-1.32-402.1.noarch.rpm
│       │   ├── EMC-ScaleIO-gui-1.32-402.1.noarch.rpm
│       │   ├── EMC-ScaleIO-lia-1.32-402.1.el7.x86_64.rpm
│       │   ├── EMC-ScaleIO-mdm-1.32-402.1.el7.x86_64.rpm
│       │   ├── EMC-ScaleIO-sdc-1.32-402.1.el7.x86_64.rpm
│       │   ├── EMC-ScaleIO-sds-1.32-402.1.el7.x86_64.rpm
│       │   ├── EMC-ScaleIO-tb-1.32-402.1.el7.x86_64.rpm
│       │   ├── EMC_ScaleIO_Software_Agreement.txt
│       │   ├── get_all_devices_dev.sh
│       │   ├── get_all_devices_prd.sh
│       │   └── parted.sh
│       ├── tasks
│       │   ├── 00_filecopy.yml
│       │   ├── 01_partition.yml
│       │   ├── 02_install.yml
│       │   ├── 03_config.yml
│       │   ├── 99_post.yml
│       │   ├── license.yml
│       │   └── main.yml
│       ├── templates
│       └── vars
│           └── main.yml
├── sample.yml
└── site.yml

7 directories, 25 files


