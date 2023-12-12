.import QtQuick.LocalStorage as LS

// 创建或打开数据库
function getDB()
{
    try {
        var db = LS.LocalStorage.openDatabaseSync("contacts", "1.0", "this is a contacts database", 1000000)
    } catch (err) {
        console.log("failed to open database: " + err)
    }

    return db
}

// 初始化数据库（建表）
function initDB()
{
    let db = getDB()

    try {
        db.transaction(function (tx) {
            tx.executeSql("CREATE TABLE IF NOT EXISTS person (name Text, phone Text)")
        })
    } catch (err) {
        console.log("failed to create table: " + err)
    }
}

// 插入记录
function insertRow(name, phone)
{
    let rowid = 0
    let db = getDB()

    db.transaction(function (tx) {
        let rs = tx.executeSql("INSERT INTO person VALUES(?, ?)", [name, phone])
        //let result = tx.executeSql("SELECT last_insert_rowid()")
        rowid = rs.insertId
    })

    return rowid
}

// 删除记录
function deleteRow(rowid)
{
    let res = false
    let db = getDB()

    db.transaction(function (tx) {
        let rs = tx.executeSql("DELETE FROM person WHERE rowid = ?", [rowid])
        res = (rs.rowsAffected > 0)
    })

    return res
}

// 更新记录
function updateRow(rowid, name, phone)
{
    let res = false
    let db = getDB()

    db.transaction(function (tx) {
        let rs = tx.executeSql("UPDATE person SET name=?, phone=? WHERE rowid = ?", [name, phone, rowid])
        res = (rs.rowsAffected > 0)
    })

    return res
}

// 读取所有记录
function readAll()
{
    let res = []
    let db = getDB()

    db.transaction(function (tx) {
        let rs = tx.executeSql("SELECT rowid, name, phone FROM person")
        for (let i = 0; i < rs.rows.length; i++) {
            res[i] = {
                rowid: rs.rows.item(i).rowid,
                name: rs.rows.item(i).name,
                phone: rs.rows.item(i).phone
            }
        }
    })

    return res
}
