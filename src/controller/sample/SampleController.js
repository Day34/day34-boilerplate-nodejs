
class SampleController {
    constructor() {}

    deleteItem(itemId) {
        return new Promise(resolve => {
            resolve(`itemId : ${itemId} 삭제 성공`);
        });
    }

    updateItem(name, age, memo) {
        return new Promise(resolve => {
            resolve(`name : ${name}, age : ${age}, memo : ${memo} 수정 성공`);
        });
    }

    saveItem(name, age, memo) {
        return new Promise(resolve => {
            resolve(`name : ${name}, age : ${age}, memo : ${memo} 저장 성공`);
        });
    }

    getItemAll() {
        return new Promise(resolve => {
            resolve([{name: 'items', age : 18, memo : '와우!'}]);
        });
    }

    getItem(itemId) {
        return new Promise(resolve => {
            resolve({itemId, name: 'item', age : 18, memo : '와우!'});
        });
    }
}

module.exports = SampleController;