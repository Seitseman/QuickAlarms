import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

Dialog {
    id: alarmDialog
    title: "Add new alarm"
    modal: true
    standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel

    property AlarmModel alarmModel

    function formatNumber(number) {
        return number < 10 && number >=0 ? "0" + number : number.toString()
    }

    onAccepted: {
        alarmModel.append({
                              "hour": hoursTumbler.currentIndex,
                              "minute": minutesTumbler.currentIndex,
                              "day": dayTumbler.currentIndex + 1,
                              "month": monthTumbler.currentIndex + 1,
                              "year": yearTumbler.years[yearTumbler.currentIndex],
                              "activated": true,
                              "label": "",
                              "repeat": false,
                              "daysToRepeat": [
                                  {"dayOfWeek": 0, "repeat": false},
                                  {"dayOfWeek": 1, "repeat": false},
                                  {"dayOfWeek": 2, "repeat": false},
                                  {"dayOfWeek": 3, "repeat": false},
                                  {"dayOfWeek": 4, "repeat": false},
                                  {"dayOfWeek": 5, "repeat": false},
                                  {"dayOfWeek": 6, "repeat": false},
                              ],
                          })
    }

    onRejected: alarmDialog.close()

    contentItem: RowLayout {
        RowLayout {
            id: rowTumbler

            Tumbler {
                id: hoursTumbler
                model: 24
                delegate: TumblerDelegate {
                    text: formatNumber(modelData)
                }
            }

            Tumbler {
                id: minutesTumbler
                model: 60
                delegate: TumblerDelegate {
                    text: formatNumber(modelData)
                }
            }
        }

        RowLayout {
            id: datePicker

            property alias dayTumbler: dayTumbler
            property alias monthTumbler: monthTumbler
            property alias yearTumbler: yearTumbler

            Layout.leftMargin: 20

            readonly property var days: [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

            Tumbler {
                id: dayTumbler

                function updateModel() {
                    let previousIndex = dayTumbler.currentIndex
                    let array = []
                    let newDays = datePicker.days[monthTumbler.currentIndex]
                    for(let i = 1; i <= newDays; ++i) {
                        array.push(i)
                    }

                    dayTumbler.model = array;
                    dayTumbler.currentIndex = Math.min(newDays - 1, previousIndex)
                }

                Component.onCompleted: updateModel()

                delegate: TumblerDelegate {
                    text: formatNumber(modelData)
                }
            }

            Tumbler {
                id: monthTumbler

                onCurrentIndexChanged: dayTumbler.updateModel()

                model: 12
                delegate: TumblerDelegate {
                    text: alarmDialog.locale.standaloneMonthName(modelData, Locale.ShortFormat)
                }
            }

            Tumbler {
                id: yearTumbler

                readonly property var years: (function(){
                    let curYear = new Date().getFullYear();
                    return [0, 1, 2].map(function(value) { return value + curYear; })
                })()

                model: years
                delegate: TumblerDelegate {
                    text: formatNumber(modelData)
                }
            }
        }
    }
}
