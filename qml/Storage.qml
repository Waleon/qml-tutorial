import QtQuick.LocalStorage 2.0
import QtQuick 2.0

QtObject {
    property string name        : "UnnamedDB"  // 数据库名称
    property string version     : "1.0"        // 数据库版本
    property string description : "No description"  // 数据库的显示名
    property int estimatedSize  : 100000       // 数据库大小（单位：字节）

    // 打开或创建数据库
    function getDB() {
        return LocalStorage.openDatabaseSync(name, version, description, estimatedSize);
    }

    // id INTEGER PRIMARY KEY AUTOINCREMENT,
    // 创建表
    function createTable() {
        var db = getDB();
        db.transaction(function(tx) {
            tx.executeSql("CREATE TABLE IF NOT EXISTS settings(key TEXT UNIQUE, value TEXT)");
        });
    }

    // 设置元素
    function setItem(key, value) {
        var db = getDB();
        var success = false;
        db.transaction(function(tx) {
            var rs = tx.executeSql("INSERT OR REPLACE INTO settings VALUES (?, ?);", [key, value]);
            success = (rs.rowsAffected > 0);
        });
        return success;
    }

    // 获取指定元素
    function getItem(key) {
        var db = getDB();
        var value = null;
        db.readTransaction(function(tx) {
            var rs = tx.executeSql("SELECT value FROM settings WHERE key=?;", [key]);
            if (rs.rows.length > 0) {
                value = rs.rows.item(0).value;
            }
        });
        return value;
    }

    // 获取所有元素
    function getAllItems() {
        var res = [];
        db.readTransaction(function(tx) {
            var rows = tx.executeSql("SELECT * FROM settings");
            for (var i = 0; i < rows.rows.length; i++) {
                res[i] = rows.rows.item(i).value;
            }
        });
        return res;
    }

    // 删除元素
    function deleteItem(key) {
        db.transaction(function(tx) {
            tx.executeSql("DELETE FROM settings WHERE key=?;", [key]);
            tx.executeSql("COMMIT;");
        });
    }

    // 删除表
    function dropTable() {
        db.transaction(function(tx) {
            tx.executeSql("DROP TABLE IF EXISTS settings;");
        });
    }
}
