/**
 * CloudFront Function: add-index-html
 * Add "index.html" if the URI does not have a file name or file extension
 */

function handler(event) {
    var request = event.request;
    var uri = request.uri;
    if (uri.endsWith('/')) {
        request.uri += 'index.html';
    } else if (!uri.includes('.')) {
        request.uri += '/index.html';
    }
    return request;
}
