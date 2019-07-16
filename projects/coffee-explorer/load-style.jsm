export default (path) => {
    const link = document.createElement('link')
    link.rel = 'stylesheet'
    link.href = path;
    document.body.appendChild(link);
}