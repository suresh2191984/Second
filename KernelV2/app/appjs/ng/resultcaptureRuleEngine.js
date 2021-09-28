angular.module('attuneKernel.services')
.factory('resultcaptureRuleEngine', ['$linq', function ($linq) {
    var msRule =
    {
        RangeType: function (jsData, type, pGender, ResultType, noteq) {
            var pResult;

            pResult = $linq.Enumerable().From(jsData.property)
                .Where(function (x) {
                    if (ResultType && noteq) {
                        return angular.lowercase(x.type) == angular.lowercase(type)
                       && angular.lowercase(x.value) == angular.lowercase(pGender)
                       && angular.lowercase(x.ResultType) != angular.lowercase(ResultType)
                       && angular.isDefined(x.ResultType)
                    }
                    if (ResultType && !noteq) {
                        return angular.lowercase(x.type) == angular.lowercase(type)
                       && angular.lowercase(x.value) == angular.lowercase(pGender)
                       && angular.lowercase(x.ResultType) == angular.lowercase(ResultType)

                    }
                    return angular.lowercase(x.type) == angular.lowercase(type)
                        && angular.lowercase(x.value) == angular.lowercase(pGender)
                })
                .Select(function (x) {
                    return x
                })
                .ToArray();

            return pResult;
        },
        /////////////////////////////////////////////////////////rules-engine//////////////////////////////

        eql: function (a, b) {
            return parseFloat(a) === parseFloat(b);
        },

        teql: function (a, b) {
            return (a) === (b);
        },

        neql: function (a, b) {
            return parseFloat(a) !== parseFloat(b);
        },
        grt: function (a, b) {
            return parseFloat(a) > parseFloat(b);
        },
        lst: function (a, b) {
            return parseFloat(a) < parseFloat(b);
        },
        grq: function (a, b) {
            return parseFloat(a) >= parseFloat(b);
        },
        lsq: function (a, b) {
            return parseFloat(a) <= parseFloat(b);
        },
        btw: function (a, b, c) {
            return a >= parseFloat(b) && a <= parseFloat(c);
        },

        checkingRule: function (a, b, c, bt) {
            pResult = "L";
            switch (c) {
                case "lst":
                   
                    if (msRule.lst(a, b)) {
                        pResult = "N";
                    }
                    break;
                case "lsq":
                    
                    if (msRule.lsq(a, b)) {
                        pResult = "N";
                    }
                    break;
                case "eql":
                   
                    if (msRule.eql(a, b)) {
                        pResult = "N";
                    }
                    break;
                case "teql":
                    pResult = "A";
                    if (msRule.teql(a, b)) {
                        pResult = "N";
                    }
                    break;
                case "grt":
                     
                    if (msRule.grt(a, b)) {
                        pResult = "N";
                    }
                    else {
                        if (msRule.lst(a, b)) {
                            pResult = "L";
                        }
                    }
                    break;
                case "grq":
                     
                    if (msRule.grq(a, b)) {
                        pResult = "N";
                    }
                    else {
                        if (msRule.lst(a, b)) {
                            pResult = "L";
                        }
                    }
                    break;
                case "btw":
                    
                    if (msRule.btw(a, bt[0], bt[1])) {
                        pResult = "N";
                    }
                    else {
                        if (msRule.lsq(a, bt[0])) {
                            pResult = "L";
                        }
                    }
                    break;
                case "eqllsq":
                    
                    if (msRule.eql(a, b)) {
                        pResult = "N";
                    }
                    else {
                        if (msRule.lsq(a, b)) {
                            pResult = "L";
                        }
                    }
                    break;

                default:
                    pResult = "N";
                    break;
            }
            return pResult;
        },
        ConvertToDays: function (b, c) {
            a = parseFloat(b);
            var ret = 0;
            switch (c) {
                case "Weeks":
                case "Week(s)":
                    ret = Math.round(a * 7);
                    break;
                case "Months":
                case "Month(s)":
                    ret = Math.round(a * 30.416666667);
                    break;
                case "Years":
                case "Year(s)":
                    ret = Math.round(a * 365);
                    break;
                case "Days":
                case "Day(s)":
                    ret = Math.round(a);
                    break;
            }
            return ret;


        },
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////
        GetRefCommonRange: function (jsdata, rangeValue) {
            var pResult = "N";

            angular.forEach(jsdata, function (Value, Key) {

                if (angular.isDefined(Value.lst)) {
                    pResult = msRule.checkingRule(rangeValue, Value.lst.text, "lst")
                }
                if (angular.isDefined(Value.lsq)) {
                    pResult = msRule.checkingRule(rangeValue, Value.lsq.text, "lsq")
                }
                if (angular.isDefined(Value.eql)) {
                    pResult = msRule.checkingRule(rangeValue, Value.eql.text, "eql")
                }
                if (angular.isDefined(Value.grt)) {
                    pResult = msRule.checkingRule(rangeValue, Value.grt.text, "grt")
                }
                if (angular.isDefined(Value.grq)) {
                    pResult = msRule.checkingRule(rangeValue, Value.grq.text, "grq")
                }
                if (angular.isDefined(Value.btw)) {
                    var c = Value.btw.text.split('-');
                    if (c.length == 2) {
                        pResult = msRule.checkingRule(rangeValue, 0, "btw", c)
                    }
                }
            })
            return pResult;
        },
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////
        GetRefAgeRange: function (jsdata, rangeValue, AgeInDays) {
            var pResult = "N";

            angular.forEach(jsdata, function (Value, Key) {

                if (angular.isDefined(Value.lst)) {
                    if (AgeInDays < msRule.ConvertToDays(Value.lst.text, Value.lst.agetype)) {
                        var pmode = Value.lst.mode;
                        var pval = Value.lst.value;
                        switch (pmode) {
                            case "lst":
                                pResult = msRule.checkingRule(rangeValue, pval, "lst")
                                break;
                            case "lsq":
                                pResult = msRule.checkingRule(rangeValue, pval, "lsq")
                                break;
                            case "eql":
                                pResult = msRule.checkingRule(rangeValue, pval, "eqllsq")
                                break;
                            case "grq":
                                pResult = msRule.checkingRule(rangeValue, pval, "grq")
                                break;
                            case "grt":
                                pResult = msRule.checkingRule(rangeValue, pval, "grt")
                                break;
                            case "btw":
                                var c = pval.split('-');
                                if (c.length == 2) {
                                    pResult = msRule.checkingRule(rangeValue, 0, "btw", c)
                                }
                                break;
                            default:

                        }
                    }
                }
                if (angular.isDefined(Value.lsq)) {
                    if (AgeInDays <= msRule.ConvertToDays(Value.lsq.text, Value.lsq.agetype)) {
                        var pmode = Value.lsq.mode;
                        var pval = Value.lsq.value;
                        switch (pmode) {
                            case "lst":
                                pResult = msRule.checkingRule(rangeValue, pval, "lst")
                                break;
                            case "lsq":
                                pResult = msRule.checkingRule(rangeValue, pval, "lsq")
                                break;
                            case "eql":
                                pResult = msRule.checkingRule(rangeValue, pval, "eqllsq")
                                break;
                            case "grq":
                                pResult = msRule.checkingRule(rangeValue, pval, "grq")
                                break;
                            case "grt":
                                pResult = msRule.checkingRule(rangeValue, pval, "grt")
                                break;
                            case "btw":
                                var c = pval.split('-');
                                if (c.length == 2) {
                                    pResult = msRule.checkingRule(rangeValue, 0, "btw", c)
                                }
                                break;
                            default:

                        }
                    }
                }
                if (angular.isDefined(Value.eql)) {
                    if (AgeInDays == msRule.ConvertToDays(Value.eql.text, Value.eql.agetype)) {
                        var pmode = Value.eql.mode;
                        var pval = Value.eql.value;
                        switch (pmode) {
                            case "lst":
                                pResult = msRule.checkingRule(rangeValue, pval, "lst")
                                break;
                            case "lsq":
                                pResult = msRule.checkingRule(rangeValue, pval, "lsq")
                                break;
                            case "eql":
                                pResult = msRule.checkingRule(rangeValue, pval, "eqllsq")
                                break;
                            case "grq":
                                pResult = msRule.checkingRule(rangeValue, pval, "grq")
                                break;
                            case "grt":
                                pResult = msRule.checkingRule(rangeValue, pval, "grt")
                                break;
                            case "btw":
                                var c = pval.split('-');
                                if (c.length == 2) {
                                    pResult = msRule.checkingRule(rangeValue, 0, "btw", c)
                                }
                                break;
                            default:

                        }
                    }
                }
                if (angular.isDefined(Value.grt)) {
                    if (AgeInDays > msRule.ConvertToDays(Value.grt.text, Value.grt.agetype)) {
                        var pmode = Value.grt.mode;
                        var pval = Value.grt.value;
                        switch (pmode) {
                            case "lst":
                                pResult = msRule.checkingRule(rangeValue, pval, "lst")
                                break;
                            case "lsq":
                                pResult = msRule.checkingRule(rangeValue, pval, "lsq")
                                break;
                            case "eql":
                                pResult = msRule.checkingRule(rangeValue, pval, "eqllsq")
                                break;
                            case "grq":
                                pResult = msRule.checkingRule(rangeValue, pval, "grq")
                                break;
                            case "grt":
                                pResult = msRule.checkingRule(rangeValue, pval, "grt")
                                break;
                            case "btw":
                                var c = pval.split('-');
                                if (c.length == 2) {
                                    pResult = msRule.checkingRule(rangeValue, 0, "btw", c)
                                }
                                break;
                            default:

                        }
                    }
                }
                if (angular.isDefined(Value.grq)) {
                    if (AgeInDays >= msRule.ConvertToDays(Value.grq.text, Value.grq.agetype)) {
                        var pmode = Value.grq.mode;
                        var pval = Value.grq.value;
                        switch (pmode) {
                            case "lst":
                                pResult = msRule.checkingRule(rangeValue, pval, "lst")
                                break;
                            case "lsq":
                                pResult = msRule.checkingRule(rangeValue, pval, "lsq")
                                break;
                            case "eql":
                                pResult = msRule.checkingRule(rangeValue, pval, "eqllsq")
                                break;
                            case "grq":
                                pResult = msRule.checkingRule(rangeValue, pval, "grq")
                                break;
                            case "grt":
                                pResult = msRule.checkingRule(rangeValue, pval, "grt")
                                break;
                            case "btw":
                                var c = pval.split('-');
                                if (c.length == 2) {
                                    pResult = msRule.checkingRule(rangeValue, 0, "btw", c)
                                }
                                break;
                            default:

                        }
                    }
                }
                if (angular.isDefined(Value.btw)) {
                    var z = Value.btw.text.split('-');
                    if (z.length == 2) {

                        if (AgeInDays > msRule.ConvertToDays(z[0], Value.btw.agetype) && AgeInDays <= msRule.ConvertToDays(z[1], Value.btw.agetype)) {

                            var pmode = Value.btw.mode;
                            var pval = Value.btw.value;
                            switch (pmode) {
                                case "lst":
                                    pResult = msRule.checkingRule(rangeValue, pval, "lst")
                                    break;
                                case "lsq":
                                    pResult = msRule.checkingRule(rangeValue, pval, "lsq")
                                    break;
                                case "eql":
                                    pResult = msRule.checkingRule(rangeValue, pval, "eqllsq")
                                    break;
                                case "grq":
                                    pResult = msRule.checkingRule(rangeValue, pval, "grq")
                                    break;
                                case "grt":
                                    pResult = msRule.checkingRule(rangeValue, pval, "grt")
                                    break;
                                case "btw":
                                    var c = pval.split('-');
                                    if (c.length == 2) {
                                        pResult = msRule.checkingRule(rangeValue, 0, "btw", c)
                                    }
                                    break;
                                default:
                            }
                        }

                    }
                }
            })
            return pResult;

        },
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////
        GetCommonRange: function (jsdata, rangeValue, type) {
            var pResult = "N";

            angular.forEach(jsdata, function (Value, Key) {

                if (angular.isDefined(Value.lst)) {
                    pResult = msRule.checkingRule(rangeValue, (type) ? Value.lst.text : Value.lst.value, "lst")
                }
                if (angular.isDefined(Value.lsq)) {
                    pResult = msRule.checkingRule(rangeValue, (type) ? Value.lsq.text : Value.lsq.value, "lsq")
                }
                if (angular.isDefined(Value.eql)) {
                    pResult = msRule.checkingRule(rangeValue, (type) ? Value.eql.text : Value.eql.value, "eqllsq")
                }
                if (angular.isDefined(Value.grt)) {
                    pResult = msRule.checkingRule(rangeValue, (type) ? Value.grt.text : Value.grt.value, "grt")
                }
                if (angular.isDefined(Value.grq)) {
                    pResult = msRule.checkingRule(rangeValue, (type) ? Value.grq.text : Value.grq.value, "grq")
                }
                if (angular.isDefined(Value.btw)) {
                    var c = (type) ? Value.btw.text.split('-') : Value.btw.value.split('-');
                    if (c.length == 2) {
                        pResult = msRule.checkingRule(rangeValue, 0, "btw", c)
                    }
                }

            });
            return pResult;
        },
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////
        GetRefOtherRange: function (jsdata, rangeValue, type) {
            var pResult = "N";

            x = $linq.Enumerable().From(jsdata)
               .Where(function (x) {
                   return (angular.isDefined(x.lst) && x.lst.Normal == "Y") || (angular.isDefined(x.lsq) && x.lsq.Normal == "Y")
                           || (angular.isDefined(x.eql) && x.eql.Normal == "Y") || (angular.isDefined(x.grt) && x.grt.Normal == "Y")
                       || (angular.isDefined(x.grq) && x.grq.Normal == "Y") || (angular.isDefined(x.btw) && x.btw.Normal == "Y")
                       
               })
               .Select(function (x) {
                   return x
               })
               .ToArray();
            if (x.length > 0) {
                jsdata = x;
            }

            angular.forEach(jsdata, function (Value, Key) {

                if (angular.isDefined(Value.lst)) {
                    var pval = parseFloat(Value.lst.text)
                    var pres;
                    if ((type) && pval > 0) {
                        pres = pvsl;
                    }
                    else {
                        pres = Value.lst.value;
                    }
                    pResult = msRule.checkingRule(rangeValue, pres, "lst")
                }
                if (angular.isDefined(Value.lsq)) {
                    var pval = parseFloat(Value.lsq.text)
                    var pres;
                    if ((type) && pval > 0) {
                        pres = pvsl;
                    }
                    else {
                        pres = Value.lsq.value;
                    }
                    pResult = msRule.checkingRule(rangeValue, pres, "lsq")
                }
                if (angular.isDefined(Value.eql)) {
                    var pval = parseFloat(Value.eql.text)
                    var pres;
                    if ((type) && pval > 0) {
                        pres = pvsl;
                    }
                    else {
                        pres = Value.eql.value;
                    }
                    pResult = msRule.checkingRule(rangeValue, pres, "eqllsq")
                }
                if (angular.isDefined(Value.grt)) {
                    var pval = parseFloat(Value.grt.text)
                    var pres;
                    if ((type) && pval > 0) {
                        pres = pvsl;
                    }
                    else {
                        pres = Value.grt.value;
                    }
                    pResult = msRule.checkingRule(rangeValue, pres, "grt")
                }
                if (angular.isDefined(Value.grq)) {
                    var pval = parseFloat(Value.grq.text)
                    var pres;
                    if ((type) && pval > 0) {
                        pres = pvsl;
                    }
                    else {
                        pres = Value.grq.value;
                    }
                    pResult = msRule.checkingRule(rangeValue, pres, "grq")
                }
                if (angular.isDefined(Value.btw)) {

                    var c = (type) ? Value.btw.text.split('-') : Value.btw.value.split('-');
                    if (c.length == 2) {
                        pResult = msRule.checkingRule(rangeValue, 0, "btw", c)
                    }
                }

            });
            return pResult;

        },
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////
        GetRefOtherRangeText: function (jsdata, rangeValue) {
            var pResult = "N";
            angular.forEach(jsdata, function (Value, Key) {
                if (angular.isDefined(Value.txt)) {
                    pResult = msRule.checkingRule(rangeValue, Value.txt.text, "teql")
                }
            });
            return pResult;
        }

    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////

    var attRule = {
        msRule: msRule,
        valuationRule: function (ReferenceRangeType, data, pGender, ageInDays, rangeValue) {
            var pResult = "N";
            var pdata;

            var IS_JSON = true;
            try {
                data = JSON.parse(data);
            }
            catch (err) {
                IS_JSON = false;
            }
            if (IS_JSON) {
                angular.forEach(ReferenceRangeType, function (Value, Key) {

                    switch (Value.Code) {
                        case "autoauthorizationrange":
                            pdata = $linq.Enumerable().From(data)
                                  .Where(function (x) {
                                      return angular.lowercase(x.autoauthorizationrange) == angular.lowercase(Value.Code)
                                  })
                                .Select(function (x) {
                                    return x.autoauthorizationrange
                                }).ToArray();
                            break;
                        case "domainrange":
                            pdata = $linq.Enumerable().From(data)
                                  .Where(function (x) {
                                      return angular.lowercase(x.domainrange) == angular.lowercase(Value.Code)
                                  })
                                .Select(function (x) {
                                    return x.domainrange
                                }).ToArray();
                            break;
                        case "panicrange":
                            pdata = $linq.Enumerable().From(data)
                                  .Where(function (x) {
                                      return angular.lowercase(x.panicrange) == angular.lowercase(Value.Code)
                                  })
                                .Select(function (x) {
                                    return x.panicrange
                                }).ToArray();
                            break;
                        case "referencerange":
                            var p = data.referenceranges.referencerange.property;
                            if (angular.isDefined(p.length) && p.length > 0) {
                                pdata = data.referenceranges.referencerange;
                            }
                            if (!angular.isDefined(p.length) && p) {
                                pdata.property = [];
                                pdata.property.push(data.referenceranges.referencerange.property)
                            }

                            break;
                        case "sensitiveresultrange":

                            pdata = $linq.Enumerable().From(data)
                                  .Where(function (x) {
                                      return angular.lowercase(x.sensitiveresultrange) == angular.lowercase(Value.Code)
                                  })
                                .Select(function (x) {
                                    return x.sensitiveresultrange
                                }).ToArray();
                            break;
                        default:
                    }
                    if (angular.isDefined(pdata.property) && pdata.property.length > 0) {
                        pResult = attRule.valuation(pdata, pGender, ageInDays, rangeValue, Value.Bound);

                        if (pResult == "A" || pResult == "L") {
                            return pResult;
                        }
                    }
                });
            }
            //else {
            //    var refrange = data.trim().split('-');
            //    if (refrange.length == 2) {
            //        if (parseInt(rangeValue) > parseInt(refrange[0]) && parseInt(rangeValue) < parseInt(refrange[1])) {
            //            pResult = "N"
            //        }
            //        else if (parseInt(rangeValue) < parseInt(refrange[0])) {
            //            pResult = "L"
            //        }
            //        else if (parseInt(rangeValue) > parseInt(refrange[1])) {
            //            pResult = "A"
            //        }
                    
            //    }
            //}
            return pResult;
        },

        validationRange: function (pVal) {
            var pres = "N";
            switch (pVal) {
                case "N":
                    pres = "L";
                    break;
                case "P":
                    pres = "N";
                    break;
                case "L":
                    pres = "A";
                    break;
                case "A":
                    pres = "P";
                    break;
            }
            return pres;
        },


        validationColor: function (pVal) {
            var pres = "NormalRange";
            switch (pVal) {
                case "N":
                    pres = "NormalRange";
                    break;
                case "P":
                    pres = "PanicRange";
                    break;
                case "L":
                    pres = "LowerAbnormalRange";
                    break;
                case "A":
                    pres = "HigherAbnormalRange";
                    break;
                case "D":
                    pres = "DeviceError";
                    break;
            }
            return pres;
        },



        ///////////////////////////////////////////////////////////////////////////////////////////////////////////
        valuation: function (data, pGender, ageInDays, rangeValue, rangetype) {
            var val;

            var ageRange = msRule.RangeType(data, "age", pGender);
            var ageRangeBoth = msRule.RangeType(data, "age", "Both");

            var commonRange = msRule.RangeType(data, "common", pGender);
            var commonRangeBoth = msRule.RangeType(data, "common", "Both");

            var otherRange = msRule.RangeType(data, "other", pGender, "Text", true);
            var otherRangeBoth = msRule.RangeType(data, "other", "Both", "Text", true);

            var otherRangeText = msRule.RangeType(data, "other", pGender, "Text", false);
            var otherRangeBothText = msRule.RangeType(data, "other", "Both", "Text", false);
            /////////////////////
            if (angular.isDefined(ageRange) && ageRange.length > 0) {
                val = msRule.GetRefAgeRange(ageRange, rangeValue, ageInDays);
                if (rangetype != "Inclusive" && (val == "A" || val == "L")) {
                    return val;
                }

            }
            if (angular.isDefined(ageRangeBoth) && ageRangeBoth.length > 0) {
                val = msRule.GetRefAgeRange(ageRangeBoth, rangeValue, ageInDays);
                if (rangetype != "Inclusive" && (val == "A" || val == "L")) {
                    return val;
                }
                if (rangetype == "Inclusive") {
                    val = (val == "A" || val == "L") ? "B" : val;
                }
            }
            /////////////////
            if (angular.isDefined(commonRange) && commonRange.length > 0) {
                val = msRule.GetRefCommonRange(commonRange, rangeValue);
                if (rangetype != "Inclusive" && (val == "A" || val == "L")) {
                    return val;
                }
                if (rangetype == "Inclusive") {
                    val = (val == "A" || val == "L") ? "B" : val;
                }
            }

            if (angular.isDefined(commonRangeBoth) && commonRangeBoth.length > 0) {


                if (rangetype == "Inclusive") {
                    val = msRule.GetCommonRange(commonRangeBoth, rangeValue, true);
                    val = (val == "A" || val == "L") ? "B" : val;
                }
                else {
                    val = msRule.GetRefCommonRange(commonRangeBoth, rangeValue);

                    return val;

                }
            }
            ////////////////
            if (angular.isDefined(otherRange) && otherRange.length > 0) {
                if (rangetype == "Inclusive") {
                    val = msRule.GetCommonRange(otherRange, rangeValue, true);
                    val = (val == "A" || val == "L") ? "B" : val;
                }
                else {
                    val = msRule.GetRefOtherRange(otherRange, rangeValue, true);
                    return val;
                }


            }
            if (angular.isDefined(otherRangeBoth) && otherRangeBoth.length > 0) {
                if (rangetype == "Inclusive") {
                    val = msRule.GetCommonRange(otherRangeBoth, rangeValue, false);
                    val = (val == "A" || val == "L") ? "B" : val;
                }
                else {
                    val = msRule.GetRefOtherRange(otherRangeBoth, rangeValue, false);
                    return val;
                }
            }

            ////////////
            if (angular.isDefined(otherRangeText) && otherRangeText.length > 0) {
                val = msRule.GetRefOtherRangeText(otherRangeText, rangeValue);
                if (rangetype != "Inclusive" && (val == "A" || val == "L")) {
                    return val;
                }
                if (rangetype == "Inclusive") {

                    val = (val == "A" || val == "L") ? "B" : val;
                }
            }
            if (angular.isDefined(otherRangeBothText) && otherRangeBothText.length > 0) {
                val = msRule.GetRefOtherRangeText(otherRangeBothText, rangeValue);
                if (rangetype != "Inclusive" && (val == "A" || val == "L")) {
                    return val;
                }
                if (rangetype == "Inclusive") {

                    val = (val == "A" || val == "L") ? "B" : val;
                }
            }

            return val;
        }
    };
    return attRule;
}]);

//if (!string.IsNullOrEmpty(item.ReferenceRange) && item.ReferenceRange.StartsWith("<?xml") )
//{

//    XElement xe = XElement.Parse(item.ReferenceRange);
//    XmlDocument doc = new XmlDocument();
//    doc.LoadXml(xe.ToString());

//    string jsonText = (Regex.Replace((JsonConvert.SerializeXmlNode(doc, Newtonsoft.Json.Formatting.Indented, true)), "(?<=\")(@)(?!.*\":\\s )", string.Empty, RegexOptions.IgnoreCase)); //JsonConvert.SerializeObject(xe, Newtonsoft.Json.Formatting.);
