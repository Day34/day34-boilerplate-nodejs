export const SERVER_HOST = process.env.SERVER_HOST;
export const SERVER_PORT = process.env.SERVER_PORT;
export const SUCCESS_MESSAGE = '정상적으로 처리되었습니다.';
export const FAILED_ERROR_MESSAGE = '처리중 에러가 발생하였습니다.';
export const RESPONSE_MESSAGE = (res, isSuccess, message, data) => {
    res.json({
        success: isSuccess,
        message,
        data
    });
};