/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {Component} from 'react';
import {StyleSheet, View, Image, ScrollView} from 'react-native';

//引入计时器
var TimerMixin = require('react-timer-mixin');
//引入json数据
var ImageData = require('./ImageData.json');
//获取屏幕宽度
var Dimensions = require('Dimensions');
var {width} = Dimensions.get('window');

type Props = {};
export default class App extends Component<Props> {
    //注册
    mixins: [TimerMixin]

    render() {
        return (
            <View style={styles.container}>
                <ScrollView
                    ref="scrollView"
                    horizontal={true}
                    showsHorizontalScrollIndicator={false}
                    pagingEnabled={true}
                >
                    {this.rendreAllImage()}
                </ScrollView>

                {/*返回指示器*/}
                <View style={}>

                </View>
            </View>
        );
    }

    //实现一些复杂的操作
    componentDidMount() {
        //开启定时器
        this.startTimer();
    }

    //开启定时器
    startTimer() {
        //1.拿到csrollview
        var scrollView = this.refs.scrollView;
        var  imgCount = ImageData.data.length;
        //2.添加定时器
        this.setInterval(function () {
            console.log('1');
            //2.1设置圆点
            var activePage = 0;
            //2.2判断
            if ((this.state.currentPage +1) >=  imgCount) {//越界
                activePage = 0;
            } else {
                activePage = this.state.currentPage + 1;
            }
            //2.3 更新状态机
            this.setState({
                currentPage: activePage
            })

        }, this.props.duration);
    }

    rendreAllImage() {
        // 数组
        var allImage = [];
        //拿到图像数组
        var imgsArr = ImageData.data;
        //遍历
        for (var i = 0; i < imgsArr.length; i++) {
            //取出单独的每一个对象
            var imgItem = imgsArr[i];
            //创建组件装入数组
            allImage.push(
                <Image key={i} source={{uri: imgItem.img}} style={{width: width, height: 120}}/>
            );
        }
        //返回数组
        return allImage;
    }
}

//设置固定值
App.defaultProps = {
    duration: 1000
}

const styles = StyleSheet.create({
    container: {
        marginTop: 25

    }
});
