<template>
    <div :style="rootStyle">
        <SearchBar @search="onSearch" :width="-1" placeholder="找教师"></SearchBar>
    </div>
</template>

<script>
    import SearchBar from "@/components/base/SearchBar";
    export default {
        name: "FindTeacherPage",
        components: {SearchBar},
        computed: {
            rootStyle: function () {
                return {
                    padding: "32px 300px"
                }
            }
        },
        methods: {
            onSearch: function (content) {
                window.console.log(content)
            }
        }
    }
</script>

<style scoped>

</style>