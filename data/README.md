The dataset used within this course was first obtained from publicly available [DepMap Portal](https://depmap.org/portal/) [data](https://depmap.org/portal/data_page/?tab=overview) (Public Version 23Q2).

Some early data wrangling and summarization steps were carried out on the raw DepMap data using [this script for another course](https://github.com/fhdsl/Intro_to_R/blob/main/classroom_data/gen_classroom_data.R). The raw DepMap data loaded within that script is not stored in this or the other course's repo because of file size constraints.

This course uses some additional data manipulation steps to add some random noise into the dataset, specifically adding some acronyms or additional spellings for some of the metadata. [This script performs those manipulations on the data.](https://github.com/fhdsl/bench_to_bytes/blob/main/data/modifyData.R) Note that the original dataset which we manipulate is loaded using `load(url("https://github.com/fhdsl/S1_Intro_to_R/raw/main/classroom_data/CCLE.RData"))`.

Our new dataset was saved as both an RData object and an Excel Spreadsheet. The RData object can be loaded using `load(url("https://github.com/fhdsl/bench_to_bytes/raw/main/data/depMapData_benchToBytes.RData"))`. The [Excel Spreadsheet can be downloaded with this link](https://github.com/fhdsl/bench_to_bytes/raw/addDataSet/data/depMapData_benchToBytes.xlsx) 
