/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {Component} from 'react';
import {StyleSheet, View, Image, Text, ScrollView} from 'react-native';

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

    //设置可变的初始值
    constructor(Props) {
        super(Props);
        this.state = {
            //当前的页码
            currentPage: 0
        }
    }

    render() {
        return (
            <View style={styles.container}>
                <ScrollView
                    ref="scrollView"
                    //设置水平分布
                    horizontal={true}
                    //隐藏水平滚动条
                    showsHorizontalScrollIndicator={false}
                    //自动分页
                    pagingEnabled={true}
                    //当一帧滚动结束 箭头方式调用
                    onMomentumScrollEnd={(e)=>this.onAnimationEnd(e)}
                >
                    {this.rendreAllImage()}
                </ScrollView>

                {/*返回指示器*/}
                <View style={styles.pageViewStyle}>
                    {/*返回5个圆点*/}
                    {this.renderPageCircle()}
                </View>
            </View>
        );
    }

    //实现一些复杂的操作
    componentDidMount() {
        //开启定时器
        // this.startTimer();
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
            // var activePage = 0;
            // //2.2判断
            // if ((this.state.currentPage +1) >=  imgCount) {//越界
            //     activePage = 0;
            // } else {
            //     activePage = this.state.currentPage + 1;
            // }
            // //2.3 更新状态机
            // this.setState({
            //     currentPage: activePage
            // })

        }, this.props.duration);
    }

    // 返回左右的图片
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
                <Image key={i} source={{uri: imgItem.img}} style={{width: width, height: 180}}/>
            );
        }
        //返回数组
        return allImage;
    }
    // 返回所有的圆点
    renderPageCircle() {
        //定义一个数组放置所有的圆点
        var indicatorArr = [];
        var style;
        //拿到图像数组
        var imgsArr = ImageData.data;
        //遍历
        for (var i = 0; i < imgsArr.length; i++) {
            //判断
            style = (i == this.state.currentPage) ? {color:'orange'} : {color:'#ffffff'};
            //把圆点装入数组
            indicatorArr.push(
                <Text key={i} style={[{fontSize: 25}, style]} >&bull;</Text>
            );
        }
        return indicatorArr;

    }
    //当一帧滚动结束时候调用
    onAnimationEnd(e) {
        //1.求出水平方向当偏移量
        var offSetX = e.nativeEvent.contentOffset.x;
        //2.求出当前当页数
        var currentPage = Math.floor(offSetX / width);
        //3.拿到状态机，重新绘制UI
        this.setState({
            //当前当页码
            currentPage: currentPage
        })
    }
}


//设置固定值
App.defaultProps = {
    duration: 1000
}

const styles = StyleSheet.create({
    container: {
        marginTop: 25
    },
    pageViewStyle: {
        width: width,
        height: 25,
        backgroundColor: 'rgba(0,0,0,0.4)',
        //定位
        position: 'absolute',
        bottom: 0,

        //设置主轴方向  水平方向
        flexDirection: 'row',
        //设置侧轴对齐方式
        alignItems: 'center'
    }

});
