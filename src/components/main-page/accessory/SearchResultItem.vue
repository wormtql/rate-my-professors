<template lang="pug">
    div(:style="rootStyle", @click="onClick", @mouseenter="hover = true",
        @mouseleave="hover = false")
        div(style="display: inline-block; width: 48px")
            img(src="../../../assets/logo.png", style="width: 48px; height: 48px; border-radius: 50%;")
        div(style="display: inline-block; width: calc(100% - 48px); vertical-align: top; padding-left: 24px; box-sizing: border-box;")
            h4(style="margin-bottom: 8px; display: inline-block;") {{ data.name }}
            //- h4(style="float: right; color: #ff7400;") 9.0
            p(style="font-size: 0.8em; color: gray") {{ data.school }}
            p(style="font-size: 0.8em; color: gray") {{ data.department }}
            p(style="font-size: 0.8em; color: gray") {{ courses }}

            
</template>

<script>
export default {
    name: "SearchResultItem",
    data: function () {
        return {
            hover: false
        }
    },
    props: {
        data: {
            type: Object,
            default: function () {
                return {
                    name: "NAME",
                    school: "SCHOOL",
                    department: "DEPARTMENT",
                    pId: "",
                    courses: ["course1", "course2"],
                    link: "#"
                }
            }
        }
    },
    methods: {
        onClick: function () {
            // let temp = this.data.link.split("/")[2];
            if (this.data.pId !== "") {
                this.$router.push(`/rate/teacher-info-test/${this.data.pId}`);
            }
            
        }
    },
    computed: {
        courses: function () {
            let ans = "";

            if (this.data.courses.length >= 1) {
                ans = this.data.courses[0];
            }
            for (let i = 1; i < this.data.courses.length; i++) {
                ans = ans + ", " + this.data.courses[i];
            }

            return ans;
        },
        rootStyle: function () {
            return {
                background: this.hover ? "#00000011" : "transparent",
                cursor: "pointer",
                transition: "300ms",
            }
        }
    }
}
</script>

<style scoped>

</style>