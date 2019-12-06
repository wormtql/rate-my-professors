<template>
    <div :style="rootStyle">
        <h1 style="font-size: 2.5em; margin-bottom: 32px">申请添加教师</h1>
        <h2>照片</h2>
        <div style="display: flex; align-items: center; margin: 32px 0">
            <img src="../../assets/logo.png"
                 style="width: 128px; height: 128px; box-shadow: 0 0 40px 0 gray; border-radius: 50%" />
            <Button1 :width="120" :height="32" color="rgb(12,34,56)" hover-color="black"
                     style="margin-left: 32px"
            >上传照片</Button1>
        </div>

        <h2>身份信息</h2>
        <MyInput style="margin: 32px 0 16px 0" :width="-1" placeholder="名 First Name" :height="64"
                 icon="signature"
        ></MyInput>
        <MyInput style="margin: 16px 0" :width="-1" placeholder="姓 Last Name" :height="64"
                 icon="signature"
        ></MyInput>
<!--        <MyInput style="margin: 16px 0 32px 0" :width="-1" placeholder="性别 Gender" :height="64"-->
<!--                 icon="mars-stroke"-->
<!--        ></MyInput>-->
        <MyComboBox style="margin: 16px 0 32px 0" :width="-1" placeholder="性别 Gender" :height="64"
                    icon="mars-stroke">
        </MyComboBox>

        <h2>教学信息</h2>
        <MyInput style="margin: 32px 0 16px 0" :width="-1" placeholder="学校 School" :height="64"
                 icon="school"
        ></MyInput>
        <MyInput style="margin: 16px 0 32px 0" :width="-1" placeholder="学院 Department" :height="64"
                 icon="graduation-cap"
        ></MyInput>

        <h2>授课信息</h2>
        <MultiTagBox style="margin: 32px 0 16px 0"></MultiTagBox>

        <div>
            <Button1 :width="200" :height="64" style="margin-top: 32px" color="rgb(21, 34, 56)" hover-color="black">提交</Button1>
        </div>
    </div>
</template>

<script>
    import MyInput from "@/components/base/input/MyInput";
    import Button1 from "@/components/base/button/Button2";
    // import MyCheck from "@/components/base/MyCheck";
    import MyComboBox from "@/components/base/MyComboBox";
    import MultiTagBox from "@/components/base/MultiTagBox";
    export default {
        name: "ApplyTeacher",
        components: {MultiTagBox, MyComboBox, Button1, MyInput},
        computed: {
            rootStyle: function () {
                return {
                    padding: "32px 200px"
                }
            }
        }
    }
</script>

<style scoped>

</style>