<template lang="pug">
    div(:style="rootStyle")
        //- div(style="width: 100%; height: 100px; box-shadow: 0 3px 50px 1px black; display: flex; justify-content: center; align-items: center;")
        search-bar(@search="onSearch", :width="-1", placeholder="搜教师, 课程等",
            style="margin-bottom: 32px")

        div(style="width: 100%; display: flex; align-items: center; justify-content: center; height: 200px;",
            v-if="loading")
            h3(style="margin-right: 24px;") 搜索中...
            loading-box(color="#123456")

        div(v-if="!loading && searched")
            div(v-if="results.length === 0", style="display: flex; justify-content: center;")
                p(style="font-size: 2em;") 没有找到结果:(
            div(v-if="results.length > 0")
                pager(@navigate="onNavigate", style="margin: 16px 8px;",
                    :total="Math.ceil(resultAmount / 10.0)",
                    :value="currentPage")

                search-result-item(style="border-bottom: 1px solid #00000011; padding: 16px 8px;",
                    v-for="(item, index) in results", :key="index", :data="item | worm")

</template>

<script>
    import SearchBar from "@/components/base/SearchBar";
    import SearchResultItem from "@/components/main-page/accessory/SearchResultItem";
    import LoadingBox from "@/components/base/idler/LoadingBox";
    import Pager from "@/components/base/Pager";

    export default {
        name: "SearchPage",
        components: {SearchBar, SearchResultItem, LoadingBox, Pager},
        computed: {
            rootStyle: function () {
                return {
                    padding: "24px 300px"
                }
            }
        },
        filters: {
            worm: function (value) {
                return {
                    name: value.pFullNameInChina ? value.pFullNameInChina : value.pFirstName + value.pLastName,
                    school: value.pSchoolName,
                    department: value.pDepartment,
                    pId: value.pId,
                    courses: value.pCourses,
                    link: value.pLink
                }
            }
        },
        data: function () {
            return {
                results: [

                ],
                loading: false,
                resultAmount: 999,
                searched: false,
                keyword: "",
                currentPage: 1
            }
        },
        methods: {
            onSearch: function (content) {
                // window.console.log(content);

                // this.loading = true;

                // this.axios
                //     .get(`http://${this.global.domain}/${this.global.prefix}search?query=${content}&offset=0&limit=10`)
                //     .then((response) => {
                //         this.loading = false;

                //         // window.console.log("search", response.data);
                //         if (response.data.code === 0) {
                //             this.results = response.data.data.content;
                //             this.resultAmount = response.data.data.total;
                //         }
                //     });
                this.searched = true;
                this.keyword = content;

                this.onNavigate(1);
            },
            onNavigate: function (page) {
                this.loading = true;
                this.currentPage = page;

                this.axios
                    .get(`http://${this.global.domain}/${this.global.prefix}search?query=${this.keyword}&offset=${page * 10 - 10}&limit=10`)
                    .then((response) => {
                        this.loading = false;

                        // window.console.log("search", response.data);
                        if (response.data.code === 0) {
                            this.results = response.data.data.content;
                            this.resultAmount = response.data.data.total;
                        }
                    });
            }
        }
    }
</script>

<style scoped>

</style>