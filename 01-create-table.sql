CREATE TABLE 管理者
(
    管理者ID           INT PRIMARY KEY,
    管理者名               VARCHAR(50)  NOT NULL,
    メールアドレス     VARCHAR(50)  NOT NULL,
    パスワードハッシュ VARCHAR(100) NOT NULL
);

CREATE TABLE 休館日
(
    日付 DATE PRIMARY KEY,
    説明 VARCHAR(100) NOT NULL
);

CREATE TABLE 利用申請
(
    利用申請ID         INT PRIMARY KEY,
    会員種別           VARCHAR(50) NOT NULL,
    利用申請ステータス VARCHAR(50) NOT NULL
);

CREATE TABLE 利用申請イベント
(
    利用申請イベントID INT PRIMARY KEY,
    利用申請ID         INT NOT NULL,
    利用申請ステータス VARCHAR(50) NOT NULL,
    イベント発生日時   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (利用申請ID) REFERENCES 利用申請 (利用申請ID)
);

CREATE TABLE 個人会員利用申請提出
(
    利用申請イベントID INT PRIMARY KEY,
    利用申請ID         INT NOT NULL,
    氏名               VARCHAR(50)  NOT NULL,
    生年月日           DATE         NOT NULL,
    電話番号           VARCHAR(12)  NOT NULL,
    メールアドレス     VARCHAR(50)  NOT NULL,
    住所               VARCHAR(200) NOT NULL,
    利用目的           VARCHAR(200) NOT NULL,
    証明書ファイルパス VARCHAR(200) NOT NULL,
    FOREIGN KEY (利用申請イベントID) REFERENCES 利用申請イベント (利用申請イベントID),
    FOREIGN KEY (利用申請ID) REFERENCES 利用申請 (利用申請ID)
);

CREATE TABLE 団体会員利用申請提出
(
    利用申請イベントID   INT PRIMARY KEY,
    利用申請ID         INT NOT NULL,
    団体名               VARCHAR(50)  NOT NULL,
    団体種別             VARCHAR(50)  NOT NULL,
    団体電話番号         VARCHAR(12)  NOT NULL,
    団体住所             VARCHAR(200) NOT NULL,
    団体メールアドレス   VARCHAR(50)  NOT NULL,
    代表者氏名           VARCHAR(50)  NOT NULL,
    代表者電話番号       VARCHAR(12)  NOT NULL,
    代表者メールアドレス VARCHAR(50)  NOT NULL,
    利用目的             VARCHAR(200) NOT NULL,
    証明書ファイルパス   VARCHAR(200) NOT NULL,
    FOREIGN KEY (利用申請イベントID) REFERENCES 利用申請イベント (利用申請イベントID),
    FOREIGN KEY (利用申請ID) REFERENCES 利用申請 (利用申請ID)
);

CREATE TABLE 利用申請承認
(
    利用申請イベントID INT PRIMARY KEY,
    利用申請ID         INT NOT NULL,
    承認管理者ID       INT NOT NULL,
    FOREIGN KEY (利用申請イベントID) REFERENCES 利用申請イベント (利用申請イベントID),
    FOREIGN KEY (利用申請ID) REFERENCES 利用申請 (利用申請ID),
    FOREIGN KEY (承認管理者ID) REFERENCES 管理者 (管理者ID)
);

CREATE TABLE 利用申請否認
(
    利用申請イベントID INT PRIMARY KEY,
    利用申請ID         INT NOT NULL,
    否認管理者ID       INT  NOT NULL,
    否認理由           VARCHAR(200) NOT NULL,
    FOREIGN KEY (利用申請イベントID) REFERENCES 利用申請イベント (利用申請イベントID),
    FOREIGN KEY (利用申請ID) REFERENCES 利用申請 (利用申請ID),
    FOREIGN KEY (否認管理者ID) REFERENCES 管理者 (管理者ID)
);

CREATE TABLE 会員
(
    会員ID   INT PRIMARY KEY,
    会員種別 VARCHAR(50) NOT NULL
);

CREATE TABLE 利用開始
(
    利用申請イベントID INT PRIMARY KEY,
    利用申請ID         INT NOT NULL,
    会員ID             INT NOT NULL,
    担当管理者ID       INT NOT NULL,
    FOREIGN KEY (利用申請イベントID) REFERENCES 利用申請イベント (利用申請イベントID),
    FOREIGN KEY (利用申請ID) REFERENCES 利用申請 (利用申請ID),
    FOREIGN KEY (会員ID) REFERENCES 会員 (会員ID),
    FOREIGN KEY (担当管理者ID) REFERENCES 管理者 (管理者ID)
);

CREATE TABLE 個人会員
(
    会員ID         INT PRIMARY KEY,
    氏名           VARCHAR(50)  NOT NULL,
    生年月日       DATE         NOT NULL,
    住所           VARCHAR(200) NOT NULL,
    電話番号       VARCHAR(12)  NOT NULL,
    メールアドレス VARCHAR(50)  NOT NULL,
    FOREIGN KEY (会員ID) REFERENCES 会員 (会員ID)
);

CREATE TABLE 団体会員
(
    会員ID               INT PRIMARY KEY,
    団体名               VARCHAR(50)  NOT NULL,
    団体種別             VARCHAR(50)  NOT NULL,
    団体電話番号         VARCHAR(12)  NOT NULL,
    団体住所             VARCHAR(200) NOT NULL,
    団体メールアドレス   VARCHAR(50)  NOT NULL,
    代表者氏名           VARCHAR(50)  NOT NULL,
    代表者電話番号       VARCHAR(12)  NOT NULL,
    代表者メールアドレス VARCHAR(50)  NOT NULL,
    FOREIGN KEY (会員ID) REFERENCES 会員 (会員ID)
);

CREATE TABLE 提携図書館
(
    会員ID       INT PRIMARY KEY,
    図書館名     VARCHAR(50)  NOT NULL,
    図書館コード VARCHAR(10)  NOT NULL,
    担当者名     VARCHAR(50)  NOT NULL,
    住所         VARCHAR(200) NOT NULL,
    電話番号     VARCHAR(12)  NOT NULL,
    FOREIGN KEY (会員ID) REFERENCES 会員 (会員ID)
);

CREATE TABLE 会員カード
(
    会員カードID INT PRIMARY KEY,
    会員ID       INT NOT NULL,
    発行日       DATE        NOT NULL,
    有効期限     DATE        NOT NULL,
    ステータス   VARCHAR(50) NOT NULL,
    FOREIGN KEY (会員ID) REFERENCES 会員 (会員ID)
);

CREATE TABLE 書誌
(
    書誌ID            VARCHAR(12) PRIMARY KEY,
    タイトル          VARCHAR(400) NOT NULL,
    タイトルよみ      VARCHAR(400) NOT NULL,
    シリーズタイトル  VARCHAR(300) NOT NULL,
    責任表示          VARCHAR(400) NOT NULL,
    出版者            VARCHAR(300) NOT NULL,
    出版地            VARCHAR(10)  NOT NULL,
    出版年月日等      VARCHAR(40)  NOT NULL,
    出版年            VARCHAR(10)  NOT NULL,
    分類_NDC          VARCHAR(60)  NOT NULL,
    分類_NDLC         VARCHAR(128) NOT NULL,
    件名標目          VARCHAR(200) NOT NULL,
    ジャンル_形式用語 VARCHAR(100) NOT NULL,
    請求記号          VARCHAR(50)  NOT NULL,
    ISBN              VARCHAR(512) NOT NULL
);

CREATE TABLE 書誌カテゴリ
(
    書誌カテゴリID INT PRIMARY KEY,
    名称           VARCHAR(100) NOT NULL,
    説明           TEXT         NOT NULL
);

CREATE TABLE 蔵書
(
    蔵書ID     INT PRIMARY KEY,
    書誌ID     VARCHAR(12) NOT NULL,
    ステータス VARCHAR(50) NOT NULL,
    保管場所   VARCHAR(100) NOT NULL,
    FOREIGN KEY (書誌ID) REFERENCES 書誌 (書誌ID)
);

CREATE TABLE 蔵書イベント
(
    蔵書イベントID   INT PRIMARY KEY,
    蔵書ID           INT NOT NULL,
    ステータス       VARCHAR(50) NOT NULL,
    イベント発生日時 DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (蔵書ID) REFERENCES 蔵書 (蔵書ID)
);

CREATE TABLE 蔵書場所移動
(
    蔵書イベントID INT PRIMARY KEY,
    蔵書ID           INT NOT NULL,
    保管場所       INT NOT NULL,
    FOREIGN KEY (蔵書イベントID) REFERENCES 蔵書イベント (蔵書イベントID),
    FOREIGN KEY (蔵書ID) REFERENCES 蔵書 (蔵書ID)
);

CREATE TABLE 蔵書処分
(
    蔵書イベントID INT PRIMARY KEY,
    蔵書ID           INT NOT NULL,
    処分理由       VARCHAR(200) NOT NULL,
    FOREIGN KEY (蔵書イベントID) REFERENCES 蔵書イベント (蔵書イベントID),
    FOREIGN KEY (蔵書ID) REFERENCES 蔵書 (蔵書ID)
);

CREATE TABLE 一括貸出
(
    一括貸出ID INT PRIMARY KEY,
    会員ID     INT NOT NULL,
    FOREIGN KEY (会員ID) REFERENCES 会員 (会員ID)
);

CREATE TABLE 貸出
(
    貸出ID         INT PRIMARY KEY,
    貸出ステータス INT NOT NULL
);

CREATE TABLE 貸出イベント
(
    貸出イベントID   INT PRIMARY KEY,
    貸出ID           INT NOT NULL,
    貸出ステータス   VARCHAR(50) NOT NULL,
    イベント発生日時 DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (貸出ID) REFERENCES 貸出 (貸出ID)
);

CREATE TABLE 貸出開始
(
    貸出イベントID INT PRIMARY KEY,
    貸出ID           INT NOT NULL,
    会員ID         INT NOT NULL,
    蔵書ID         INT NOT NULL,
    貸出日         DATE        NOT NULL,
    貸出期限       DATE        NOT NULL,
    FOREIGN KEY (貸出イベントID) REFERENCES 貸出イベント (貸出イベントID),
    FOREIGN KEY (貸出ID) REFERENCES 貸出 (貸出ID),
    FOREIGN KEY (会員ID) REFERENCES 会員 (会員ID),
    FOREIGN KEY (蔵書ID) REFERENCES 蔵書 (蔵書ID)
);

CREATE TABLE 延長
(
    延長ID         INT PRIMARY KEY,
    貸出イベントID INT NOT NULL,
    貸出ID           INT NOT NULL,
    延長日         DATE        NOT NULL,
    延長期限       DATE        NOT NULL,
    FOREIGN KEY (貸出イベントID) REFERENCES 貸出イベント (貸出イベントID),
    FOREIGN KEY (貸出ID) REFERENCES 貸出 (貸出ID)
);

CREATE TABLE 返却
(
    貸出イベントID INT PRIMARY KEY,
    貸出ID           INT NOT NULL,
    返却日         DATE NOT NULL,
    FOREIGN KEY (貸出イベントID) REFERENCES 貸出イベント (貸出イベントID),
    FOREIGN KEY (貸出ID) REFERENCES 貸出 (貸出ID)
);

CREATE TABLE 強制キャンセル
(
    貸出イベントID     INT PRIMARY KEY,
    貸出ID           INT NOT NULL,
    強制キャンセル日   DATE         NOT NULL,
    強制キャンセル理由 VARCHAR(200) NOT NULL,
    管理者ID           INT  NOT NULL,
    FOREIGN KEY (貸出イベントID) REFERENCES 貸出イベント (貸出イベントID),
    FOREIGN KEY (貸出ID) REFERENCES 貸出 (貸出ID),
    FOREIGN KEY (管理者ID) REFERENCES 管理者 (管理者ID)
);

CREATE TABLE 貸出中
(
    貸出ID   INT PRIMARY KEY,
    会員ID   INT NOT NULL,
    蔵書ID   INT NOT NULL,
    貸出日   DATE        NOT NULL,
    貸出期限 DATE        NOT NULL,
    FOREIGN KEY (貸出ID) REFERENCES 貸出 (貸出ID),
    FOREIGN KEY (会員ID) REFERENCES 会員 (会員ID),
    FOREIGN KEY (蔵書ID) REFERENCES 蔵書 (蔵書ID)
);

CREATE TABLE 予約
(
    予約ID         INT PRIMARY KEY,
    予約ステータス VARCHAR(50) NOT NULL
);

CREATE TABLE 予約イベント
(
    予約イベントID   INT PRIMARY KEY,
    予約ID           INT NOT NULL,
    予約ステータス   VARCHAR(50) NOT NULL,
    イベント発生日時 DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (予約ID) REFERENCES 予約 (予約ID)
);

CREATE TABLE 予約申込
(
    予約イベントID INT PRIMARY KEY,
    予約ID           INT NOT NULL,
    会員ID         INT NOT NULL,
    書誌ID         VARCHAR(12) NOT NULL,
    予約開始日     DATE        NOT NULL,
    FOREIGN KEY (予約イベントID) REFERENCES 予約イベント (予約イベントID),
    FOREIGN KEY (予約ID) REFERENCES 予約 (予約ID),
    FOREIGN KEY (会員ID) REFERENCES 会員 (会員ID),
    FOREIGN KEY (書誌ID) REFERENCES 書誌 (書誌ID)
);

CREATE TABLE 予約キャンセル
(
    予約イベントID   INT PRIMARY KEY,
    予約ID           INT NOT NULL,
    予約キャンセル日時 DATE NOT NULL,
    FOREIGN KEY (予約イベントID) REFERENCES 予約イベント (予約イベントID),
    FOREIGN KEY (予約ID) REFERENCES 予約 (予約ID)
);

CREATE TABLE 予約無効
(
    予約イベントID INT PRIMARY KEY,
    予約ID           INT NOT NULL,
    無効化理由     VARCHAR(200) NOT NULL,
    無効化管理者ID INT  NOT NULL,
    FOREIGN KEY (予約イベントID) REFERENCES 予約イベント (予約イベントID),
    FOREIGN KEY (予約ID) REFERENCES 予約 (予約ID),
    FOREIGN KEY (無効化管理者ID) REFERENCES 管理者 (管理者ID)
);

CREATE TABLE 予約取置き
(
    予約イベントID INT PRIMARY KEY,
    予約ID           INT NOT NULL,
    取置き開始日   DATE NOT NULL,
    取り置き期限   DATE NOT NULL,
    FOREIGN KEY (予約イベントID) REFERENCES 予約イベント (予約イベントID),
    FOREIGN KEY (予約ID) REFERENCES 予約 (予約ID)
);

CREATE TABLE 予約貸出完了
(
    予約イベントID INT PRIMARY KEY,
    予約ID           INT NOT NULL,
    貸出ID         INT NOT NULL,
    FOREIGN KEY (予約イベントID) REFERENCES 予約イベント (予約イベントID),
    FOREIGN KEY (予約ID) REFERENCES 予約 (予約ID),
    FOREIGN KEY (貸出ID) REFERENCES 貸出 (貸出ID)
);

CREATE TABLE 予約中
(
    予約ID INT PRIMARY KEY,
    会員ID INT NOT NULL,
    書誌ID VARCHAR(12) NOT NULL,
    予約日 DATE        NOT NULL,
    FOREIGN KEY (予約ID) REFERENCES 予約 (予約ID),
    FOREIGN KEY (会員ID) REFERENCES 会員 (会員ID),
    FOREIGN KEY (書誌ID) REFERENCES 書誌 (書誌ID)
);

CREATE TABLE 取置き中
(
    予約ID     INT PRIMARY KEY,
    会員ID     INT NOT NULL,
    蔵書ID     INT NOT NULL,
    取置き日   DATE        NOT NULL,
    取置き期限 DATE        NOT NULL,
    FOREIGN KEY (予約ID) REFERENCES 予約 (予約ID),
    FOREIGN KEY (会員ID) REFERENCES 会員 (会員ID),
    FOREIGN KEY (蔵書ID) REFERENCES 蔵書 (蔵書ID)
);

CREATE TABLE 相互貸渡
(
    相互貸渡ID         INT PRIMARY KEY,
    相互貸渡ステータス VARCHAR(50) NOT NULL
);

CREATE TABLE 相互貸渡イベント
(
    相互貸渡イベントID INT PRIMARY KEY,
    相互貸渡ID         INT NOT NULL,
    相互貸渡ステータス VARCHAR(50) NOT NULL,
    イベント発生日時   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (相互貸渡ID) REFERENCES 相互貸渡 (相互貸渡ID)
);

CREATE TABLE 相互貸渡申込
(
    相互貸渡イベントID INT PRIMARY KEY,
    相互貸渡ID         INT NOT NULL,
    提携図書館ID       INT NOT NULL,
    書誌ID             VARCHAR(12) NOT NULL,
    郵送先住所         VARCHAR(200) NOT NULL,
    郵送先電話番号     VARCHAR(12) NOT NULL,
    郵送先氏名         VARCHAR(50) NOT NULL,
    利用料             INT         NOT NULL,
    入金期限           DATE        NOT NULL,
    FOREIGN KEY (相互貸渡イベントID) REFERENCES 相互貸渡イベント (相互貸渡イベントID),
    FOREIGN KEY (相互貸渡ID) REFERENCES 相互貸渡 (相互貸渡ID),
    FOREIGN KEY (提携図書館ID) REFERENCES 提携図書館 (会員ID),
    FOREIGN KEY (書誌ID) REFERENCES 書誌 (書誌ID)
);

CREATE TABLE 相互貸渡入金
(
    相互貸渡イベントID INT PRIMARY KEY,
    相互貸渡ID         INT NOT NULL,
    入金日             DATE        NOT NULL,
    予約ID             INT NOT NULL,
    FOREIGN KEY (相互貸渡イベントID) REFERENCES 相互貸渡イベント (相互貸渡イベントID),
    FOREIGN KEY (相互貸渡ID) REFERENCES 相互貸渡 (相互貸渡ID),
    FOREIGN KEY (予約ID) REFERENCES 予約 (予約ID)
);

CREATE TABLE 相互貸渡郵送
(
    相互貸渡イベントID INT PRIMARY KEY,
    相互貸渡ID         INT NOT NULL,
    郵送日             DATE        NOT NULL,
    貸出ID             INT NOT NULL,
    FOREIGN KEY (相互貸渡イベントID) REFERENCES 相互貸渡イベント (相互貸渡イベントID),
    FOREIGN KEY (相互貸渡ID) REFERENCES 相互貸渡 (相互貸渡ID),
    FOREIGN KEY (貸出ID) REFERENCES 貸出 (貸出ID)
);

CREATE TABLE 弁償請求
(
    弁償請求ID INT PRIMARY KEY,
    会員ID     INT  NOT NULL,
    蔵書ID     INT  NOT NULL,
    貸出ID     INT  NOT NULL,
    請求理由   VARCHAR(200) NOT NULL,
    請求金額   INT          NOT NULL,
    請求日     DATE         NOT NULL,
    FOREIGN KEY (会員ID) REFERENCES 会員 (会員ID),
    FOREIGN KEY (蔵書ID) REFERENCES 蔵書 (蔵書ID),
    FOREIGN KEY (貸出ID) REFERENCES 貸出 (貸出ID)
);

CREATE TABLE 弁償入金
(
    弁償請求ID INT PRIMARY KEY,
    入金日     DATE NOT NULL,
    FOREIGN KEY (弁償請求ID) REFERENCES 弁償請求 (弁償請求ID)
);