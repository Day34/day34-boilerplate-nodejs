let arr;

beforeEach(() => {
    console.log(`테스트 시작`);
    console.log(`Array Init`);
    arr = [3, 4];
});

test('sample jest testing', () => {
    expect(arr[1]).toBeGreaterThan(arr[0]);
});

afterEach(() => {
    console.log(`테스트 종료`);
});
