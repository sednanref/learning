/*
import Home from '../components/Home';
import About from '../components/About';
*/
module.exports = {
    login: {
        path: '/',
        method: 'get',
        page: 'login',
        title: 'Log In',
        handler: require('../components/Login')
    },
    feed: {
        path: '/feed',
        method: 'get',
        page: 'feed',
        title: 'Your Feed',
        handler: require('../components/Feed')
    }
}
/*
export default {
    home: {
        path: '/',
        method: 'get',
        page: 'home',
        title: 'Home',
        handler: Home
    },
    about: {
        path: '/about',
        method: 'get',
        page: 'about',
        title: 'About',
        handler: About
    }
};
*/
