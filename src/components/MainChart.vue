<template>
  <div class="rows" :class="afclass">
    <div class="chart-row" v-for="[year, issues] in issues">
      <div class="year" :id="`year${year}`">
        {{ year }}
      </div>
      <div class="issues-list">
        <issue v-for="issue in issues" :issue="issue" />
      </div>
    </div>
  </div>
</template>
<script lang="ts">
import Issue from "./IssueBlock.vue";
import { defineComponent, PropType } from "vue";

export default defineComponent({
  name: "MainChart",
  components: { Issue },
  props: {
    issuesByYear: {
      type: Object as PropType<Map<number, IssueInfo[]>>,
      required: true,
    },
    loading: {
      type: Boolean as PropType<boolean>,
      required: false,
    },
  },
  computed: {
    issues(): Map<number, IssueInfo[]> {
      if (this.loading) {
        const group = new Map();
        for (const year in [...Array(35).keys()]) {
          const issues = [] as IssueInfo[];
          group.set(year, issues);
          for (const number of [...Array(24).keys()]) {
            issues.push({ year, number });
          }
        }
        return group;
      } else {
        return this.issuesByYear;
      }
    },
    afclass() {
      let now = new Date();

      let day = now.getDate();
      let month = now.getUTCMonth();

      if (day == 1 && month == 3) {
        return ["flip"];
      } else {
        return [];
      }
    },
  },
});
</script>

<style lang="scss">
@import "../style";

.loading .year {
  animation: loadingBg 400ms infinite linear alternate;
  color: transparent;
  max-width: 15%;
}

@keyframes flip {
  from,
  80% {
    transform: rotateZ(180deg) translate(0px);
  }
}
.flip {
  animation: flip 4s ease-out;
}

.year {
  padding: 0;
  margin-right: 8px;
  font-size: 1.2em;
  min-width: 40px;
  margin-bottom: 4px;
  @include sm {
    width: auto;
    margin-top: 4px;
  }
  @include md {
    font-size: 12px;
    margin-top: 0;
    margin-bottom: 0;
  }
}

.issues-list {
  display: flex;
  flex-wrap: wrap-reverse;

  @include md {
    flex-wrap: nowrap;
  }
}

#year1992-2 {
  @include md {
        margin-right: $issueWidthMd + 162;
      }
      @include lg {
        margin-right: $issueWidthLg + 202;
      }
}

.rows {
  & > div:last-of-type {
    .year {
      @include md {
        margin-right: $issueWidthMd + 333;
      }
      @include lg {
        margin-right: $issueWidthLg + 418;
      }
    }

    .issues-list {
      @include md {
        margin-right: $issueWidthMd + 2;
      }
      @include lg {
        margin-right: $issueWidthLg + 2;
      }
    }
  }
}

.chart-row {
  display: flex;
  width: 100%;
  margin-top: 8px;
  flex-direction: column;

  @include md {
    flex-direction: row;
    flex-wrap: nowrap;
    margin-top: 0;
  }

  &:hover {
    .issue {
      filter: brightness(80%);
    }
  }
}
</style>