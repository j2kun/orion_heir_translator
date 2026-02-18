module @"traced/LinearRegression.mlir" {
  func.func @_hecate_LinearRegression(%arg0: tensor<1x!ckks.poly<2 * 13>>, %arg1: tensor<1x!ckks.poly<2 * 13>>) -> (tensor<1x!ckks.poly<2 * 1>>, tensor<1x!ckks.poly<2 * 2>>) attributes {arg_scale = array<i64: 40, 40>, btp_target = array<i64: 1>, init_level = 13 : i64, res_scale = array<i64: 40, 60>, selected_set = 1 : i64, smu0 = 0 : i64, smu1 = 1 : i64, smu_attached = false} {
    %0 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %1 = "ckks.modswitchc"(%0, %arg1) <{downFactor = 11 : i64}> : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 13>>) -> tensor<1x!ckks.poly<2 * 2>>
    %2 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %3 = "ckks.negatec"(%2, %1) : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %4 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %5 = tensor.empty() : tensor<1x!ckks.poly<1 * 2>>
    %6 = "ckks.encode"(%5) <{level = 2 : i64, scale = 20 : i64, value = -1 : i64}> : (tensor<1x!ckks.poly<1 * 2>>) -> tensor<1x!ckks.poly<1 * 2>>
    %7 = "ckks.mulcp"(%4, %3, %6) : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<1 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %8 = tensor.empty() : tensor<1x!ckks.poly<2 * 13>>
    %9 = "ckks.bootstrapc"(%8, %7) <{level = 13 : i64}> : (tensor<1x!ckks.poly<2 * 13>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 13>>
    %10 = tensor.empty() : tensor<1x!ckks.poly<2 * 6>>
    %11 = "ckks.modswitchc"(%10, %arg0) <{downFactor = 7 : i64}> : (tensor<1x!ckks.poly<2 * 6>>, tensor<1x!ckks.poly<2 * 13>>) -> tensor<1x!ckks.poly<2 * 6>>
    %12 = tensor.empty() : tensor<1x!ckks.poly<2 * 6>>
    %13 = tensor.empty() : tensor<1x!ckks.poly<1 * 6>>
    %14 = "ckks.encode"(%13) <{level = 6 : i64, scale = 20 : i64, value = -1 : i64}> : (tensor<1x!ckks.poly<1 * 6>>) -> tensor<1x!ckks.poly<1 * 6>>
    %15 = "ckks.mulcp"(%12, %11, %14) : (tensor<1x!ckks.poly<2 * 6>>, tensor<1x!ckks.poly<2 * 6>>, tensor<1x!ckks.poly<1 * 6>>) -> tensor<1x!ckks.poly<2 * 6>>
    %16 = tensor.empty() : tensor<1x!ckks.poly<2 * 6>>
    %17 = "ckks.modswitchc"(%16, %9) <{downFactor = 7 : i64}> : (tensor<1x!ckks.poly<2 * 6>>, tensor<1x!ckks.poly<2 * 13>>) -> tensor<1x!ckks.poly<2 * 6>>
    %18 = tensor.empty() : tensor<1x!ckks.poly<2 * 6>>
    %19 = "ckks.addcc"(%18, %15, %17) : (tensor<1x!ckks.poly<2 * 6>>, tensor<1x!ckks.poly<2 * 6>>, tensor<1x!ckks.poly<2 * 6>>) -> tensor<1x!ckks.poly<2 * 6>>
    %20 = tensor.empty() : tensor<1x!ckks.poly<2 * 6>>
    %21 = "ckks.mulcc"(%20, %19, %11) : (tensor<1x!ckks.poly<2 * 6>>, tensor<1x!ckks.poly<2 * 6>>, tensor<1x!ckks.poly<2 * 6>>) -> tensor<1x!ckks.poly<2 * 6>>
    %22 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %23 = "ckks.rescalec"(%22, %21) : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 6>>) -> tensor<1x!ckks.poly<2 * 5>>
    %24 = tensor.empty() : tensor<1x!ckks.poly<1 * 5>>
    %25 = "ckks.encode"(%24) <{level = 5 : i64, scale = 40 : i64, value = 2 : i64}> : (tensor<1x!ckks.poly<1 * 5>>) -> tensor<1x!ckks.poly<1 * 5>>
    %26 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %27 = "ckks.mulcp"(%26, %23, %25) : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<1 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %28 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %29 = "ckks.rotatec"(%28, %27) <{offset = array<i64: 2048>}> : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %30 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %31 = "ckks.addcc"(%30, %27, %29) : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %32 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %33 = "ckks.rotatec"(%32, %31) <{offset = array<i64: 1024>}> : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %34 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %35 = "ckks.addcc"(%34, %31, %33) : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %36 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %37 = "ckks.rotatec"(%36, %35) <{offset = array<i64: 512>}> : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %38 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %39 = "ckks.addcc"(%38, %35, %37) : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %40 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %41 = "ckks.rotatec"(%40, %39) <{offset = array<i64: 256>}> : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %42 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %43 = "ckks.addcc"(%42, %39, %41) : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %44 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %45 = "ckks.rotatec"(%44, %43) <{offset = array<i64: 128>}> : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %46 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %47 = "ckks.addcc"(%46, %43, %45) : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %48 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %49 = "ckks.rotatec"(%48, %47) <{offset = array<i64: 64>}> : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %50 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %51 = "ckks.addcc"(%50, %47, %49) : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %52 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %53 = "ckks.rotatec"(%52, %51) <{offset = array<i64: 32>}> : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %54 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %55 = "ckks.addcc"(%54, %51, %53) : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %56 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %57 = "ckks.rotatec"(%56, %55) <{offset = array<i64: 16>}> : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %58 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %59 = "ckks.addcc"(%58, %55, %57) : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %60 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %61 = "ckks.rotatec"(%60, %59) <{offset = array<i64: 8>}> : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %62 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %63 = "ckks.addcc"(%62, %59, %61) : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %64 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %65 = "ckks.rotatec"(%64, %63) <{offset = array<i64: 4>}> : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %66 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %67 = "ckks.addcc"(%66, %63, %65) : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %68 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %69 = "ckks.rotatec"(%68, %67) <{offset = array<i64: 2>}> : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %70 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %71 = "ckks.addcc"(%70, %67, %69) : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %72 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %73 = "ckks.rotatec"(%72, %71) <{offset = array<i64: 1>}> : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %74 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %75 = "ckks.addcc"(%74, %71, %73) : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %76 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %77 = "ckks.modswitchc"(%76, %19) <{downFactor = 1 : i64}> : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 6>>) -> tensor<1x!ckks.poly<2 * 5>>
    %78 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %79 = "ckks.mulcp"(%78, %77, %25) : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<1 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %80 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %81 = "ckks.rescalec"(%80, %79) : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 5>>) -> tensor<1x!ckks.poly<2 * 4>>
    %82 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %83 = "ckks.rotatec"(%82, %81) <{offset = array<i64: 2048>}> : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %84 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %85 = "ckks.addcc"(%84, %81, %83) : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %86 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %87 = "ckks.rotatec"(%86, %85) <{offset = array<i64: 1024>}> : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %88 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %89 = "ckks.addcc"(%88, %85, %87) : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %90 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %91 = "ckks.rotatec"(%90, %89) <{offset = array<i64: 512>}> : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %92 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %93 = "ckks.addcc"(%92, %89, %91) : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %94 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %95 = "ckks.rotatec"(%94, %93) <{offset = array<i64: 256>}> : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %96 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %97 = "ckks.addcc"(%96, %93, %95) : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %98 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %99 = "ckks.rotatec"(%98, %97) <{offset = array<i64: 128>}> : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %100 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %101 = "ckks.addcc"(%100, %97, %99) : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %102 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %103 = "ckks.rotatec"(%102, %101) <{offset = array<i64: 64>}> : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %104 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %105 = "ckks.addcc"(%104, %101, %103) : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %106 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %107 = "ckks.rotatec"(%106, %105) <{offset = array<i64: 32>}> : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %108 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %109 = "ckks.addcc"(%108, %105, %107) : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %110 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %111 = "ckks.rotatec"(%110, %109) <{offset = array<i64: 16>}> : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %112 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %113 = "ckks.addcc"(%112, %109, %111) : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %114 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %115 = "ckks.rotatec"(%114, %113) <{offset = array<i64: 8>}> : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %116 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %117 = "ckks.addcc"(%116, %113, %115) : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %118 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %119 = "ckks.rotatec"(%118, %117) <{offset = array<i64: 4>}> : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %120 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %121 = "ckks.addcc"(%120, %117, %119) : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %122 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %123 = "ckks.rotatec"(%122, %121) <{offset = array<i64: 2>}> : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %124 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %125 = "ckks.addcc"(%124, %121, %123) : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %126 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %127 = "ckks.rotatec"(%126, %125) <{offset = array<i64: 1>}> : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %128 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %129 = "ckks.addcc"(%128, %125, %127) : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %130 = tensor.empty() : tensor<1x!ckks.poly<1 * 5>>
    %131 = "ckks.encode"(%130) <{level = 5 : i64, scale = 40 : i64, value = 1 : i64}> : (tensor<1x!ckks.poly<1 * 5>>) -> tensor<1x!ckks.poly<1 * 5>>
    %132 = tensor.empty() : tensor<1x!ckks.poly<2 * 5>>
    %133 = "ckks.mulcp"(%132, %75, %131) : (tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<2 * 5>>, tensor<1x!ckks.poly<1 * 5>>) -> tensor<1x!ckks.poly<2 * 5>>
    %134 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %135 = "ckks.rescalec"(%134, %133) : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 5>>) -> tensor<1x!ckks.poly<2 * 4>>
    %136 = tensor.empty() : tensor<1x!ckks.poly<1 * 4>>
    %137 = "ckks.encode"(%136) <{level = 4 : i64, scale = 40 : i64, value = 1 : i64}> : (tensor<1x!ckks.poly<1 * 4>>) -> tensor<1x!ckks.poly<1 * 4>>
    %138 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %139 = "ckks.mulcp"(%138, %129, %137) : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<1 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %140 = tensor.empty() : tensor<1x!ckks.poly<1 * 4>>
    %141 = "ckks.encode"(%140) <{level = 4 : i64, scale = 60 : i64, value = 0 : i64}> : (tensor<1x!ckks.poly<1 * 4>>) -> tensor<1x!ckks.poly<1 * 4>>
    %142 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %143 = "ckks.addcp"(%142, %135, %141) : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<1 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %144 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %145 = "ckks.modswitchc"(%144, %arg0) <{downFactor = 9 : i64}> : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 13>>) -> tensor<1x!ckks.poly<2 * 4>>
    %146 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %147 = "ckks.mulcc"(%146, %145, %143) : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %148 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %149 = "ckks.rescalec"(%148, %147) : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 3>>
    %150 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %151 = tensor.empty() : tensor<1x!ckks.poly<1 * 4>>
    %152 = "ckks.encode"(%151) <{level = 4 : i64, scale = 20 : i64, value = -1 : i64}> : (tensor<1x!ckks.poly<1 * 4>>) -> tensor<1x!ckks.poly<1 * 4>>
    %153 = "ckks.mulcp"(%150, %139, %152) : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<1 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %154 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %155 = "ckks.rescalec"(%154, %153) : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 3>>
    %156 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %157 = "ckks.addcc"(%156, %149, %155) : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %158 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %159 = "ckks.modswitchc"(%158, %9) <{downFactor = 9 : i64}> : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 13>>) -> tensor<1x!ckks.poly<2 * 4>>
    %160 = tensor.empty() : tensor<1x!ckks.poly<2 * 4>>
    %161 = tensor.empty() : tensor<1x!ckks.poly<1 * 4>>
    %162 = "ckks.encode"(%161) <{level = 4 : i64, scale = 40 : i64, value = -1 : i64}> : (tensor<1x!ckks.poly<1 * 4>>) -> tensor<1x!ckks.poly<1 * 4>>
    %163 = "ckks.mulcp"(%160, %159, %162) : (tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<2 * 4>>, tensor<1x!ckks.poly<1 * 4>>) -> tensor<1x!ckks.poly<2 * 4>>
    %164 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %165 = "ckks.rescalec"(%164, %163) : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 3>>
    %166 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %167 = "ckks.addcc"(%166, %157, %165) : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %168 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %169 = "ckks.modswitchc"(%168, %arg0) <{downFactor = 10 : i64}> : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 13>>) -> tensor<1x!ckks.poly<2 * 3>>
    %170 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %171 = "ckks.mulcc"(%170, %167, %169) : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %172 = tensor.empty() : tensor<1x!ckks.poly<1 * 3>>
    %173 = "ckks.encode"(%172) <{level = 3 : i64, scale = 40 : i64, value = 2 : i64}> : (tensor<1x!ckks.poly<1 * 3>>) -> tensor<1x!ckks.poly<1 * 3>>
    %174 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %175 = "ckks.mulcp"(%174, %171, %173) : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<1 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %176 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %177 = "ckks.rescalec"(%176, %175) : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 2>>
    %178 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %179 = "ckks.rotatec"(%178, %177) <{offset = array<i64: 2048>}> : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %180 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %181 = "ckks.addcc"(%180, %177, %179) : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %182 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %183 = "ckks.rotatec"(%182, %181) <{offset = array<i64: 1024>}> : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %184 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %185 = "ckks.addcc"(%184, %181, %183) : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %186 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %187 = "ckks.rotatec"(%186, %185) <{offset = array<i64: 512>}> : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %188 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %189 = "ckks.addcc"(%188, %185, %187) : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %190 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %191 = "ckks.rotatec"(%190, %189) <{offset = array<i64: 256>}> : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %192 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %193 = "ckks.addcc"(%192, %189, %191) : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %194 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %195 = "ckks.rotatec"(%194, %193) <{offset = array<i64: 128>}> : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %196 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %197 = "ckks.addcc"(%196, %193, %195) : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %198 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %199 = "ckks.rotatec"(%198, %197) <{offset = array<i64: 64>}> : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %200 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %201 = "ckks.addcc"(%200, %197, %199) : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %202 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %203 = "ckks.rotatec"(%202, %201) <{offset = array<i64: 32>}> : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %204 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %205 = "ckks.addcc"(%204, %201, %203) : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %206 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %207 = "ckks.rotatec"(%206, %205) <{offset = array<i64: 16>}> : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %208 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %209 = "ckks.addcc"(%208, %205, %207) : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %210 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %211 = "ckks.rotatec"(%210, %209) <{offset = array<i64: 8>}> : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %212 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %213 = "ckks.addcc"(%212, %209, %211) : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %214 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %215 = "ckks.rotatec"(%214, %213) <{offset = array<i64: 4>}> : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %216 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %217 = "ckks.addcc"(%216, %213, %215) : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %218 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %219 = "ckks.rotatec"(%218, %217) <{offset = array<i64: 2>}> : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %220 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %221 = "ckks.addcc"(%220, %217, %219) : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %222 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %223 = "ckks.rotatec"(%222, %221) <{offset = array<i64: 1>}> : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %224 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %225 = "ckks.addcc"(%224, %221, %223) : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %226 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %227 = "ckks.mulcp"(%226, %167, %173) : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<1 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %228 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %229 = "ckks.rotatec"(%228, %227) <{offset = array<i64: 2048>}> : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %230 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %231 = "ckks.addcc"(%230, %227, %229) : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %232 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %233 = "ckks.rotatec"(%232, %231) <{offset = array<i64: 1024>}> : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %234 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %235 = "ckks.addcc"(%234, %231, %233) : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %236 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %237 = "ckks.rotatec"(%236, %235) <{offset = array<i64: 512>}> : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %238 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %239 = "ckks.addcc"(%238, %235, %237) : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %240 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %241 = "ckks.rotatec"(%240, %239) <{offset = array<i64: 256>}> : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %242 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %243 = "ckks.addcc"(%242, %239, %241) : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %244 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %245 = "ckks.rotatec"(%244, %243) <{offset = array<i64: 128>}> : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %246 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %247 = "ckks.addcc"(%246, %243, %245) : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %248 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %249 = "ckks.rotatec"(%248, %247) <{offset = array<i64: 64>}> : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %250 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %251 = "ckks.addcc"(%250, %247, %249) : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %252 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %253 = "ckks.rotatec"(%252, %251) <{offset = array<i64: 32>}> : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %254 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %255 = "ckks.addcc"(%254, %251, %253) : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %256 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %257 = "ckks.rotatec"(%256, %255) <{offset = array<i64: 16>}> : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %258 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %259 = "ckks.addcc"(%258, %255, %257) : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %260 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %261 = "ckks.rotatec"(%260, %259) <{offset = array<i64: 8>}> : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %262 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %263 = "ckks.addcc"(%262, %259, %261) : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %264 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %265 = "ckks.rotatec"(%264, %263) <{offset = array<i64: 4>}> : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %266 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %267 = "ckks.addcc"(%266, %263, %265) : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %268 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %269 = "ckks.rotatec"(%268, %267) <{offset = array<i64: 2>}> : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %270 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %271 = "ckks.addcc"(%270, %267, %269) : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %272 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %273 = "ckks.rotatec"(%272, %271) <{offset = array<i64: 1>}> : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %274 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %275 = "ckks.addcc"(%274, %271, %273) : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %276 = tensor.empty() : tensor<1x!ckks.poly<1 * 2>>
    %277 = "ckks.encode"(%276) <{level = 2 : i64, scale = 40 : i64, value = 1 : i64}> : (tensor<1x!ckks.poly<1 * 2>>) -> tensor<1x!ckks.poly<1 * 2>>
    %278 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %279 = "ckks.mulcp"(%278, %225, %277) : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<1 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %280 = tensor.empty() : tensor<1x!ckks.poly<2 * 1>>
    %281 = "ckks.rescalec"(%280, %279) : (tensor<1x!ckks.poly<2 * 1>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 1>>
    %282 = tensor.empty() : tensor<1x!ckks.poly<1 * 3>>
    %283 = "ckks.encode"(%282) <{level = 3 : i64, scale = 40 : i64, value = 1 : i64}> : (tensor<1x!ckks.poly<1 * 3>>) -> tensor<1x!ckks.poly<1 * 3>>
    %284 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %285 = "ckks.mulcp"(%284, %275, %283) : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<1 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %286 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %287 = "ckks.rescalec"(%286, %285) : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 2>>
    %288 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %289 = "ckks.modswitchc"(%288, %143) <{downFactor = 2 : i64}> : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 2>>
    %290 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %291 = tensor.empty() : tensor<1x!ckks.poly<1 * 2>>
    %292 = "ckks.encode"(%291) <{level = 2 : i64, scale = 40 : i64, value = -1 : i64}> : (tensor<1x!ckks.poly<1 * 2>>) -> tensor<1x!ckks.poly<1 * 2>>
    %293 = "ckks.mulcp"(%290, %289, %292) : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<1 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %294 = tensor.empty() : tensor<1x!ckks.poly<2 * 1>>
    %295 = "ckks.rescalec"(%294, %293) : (tensor<1x!ckks.poly<2 * 1>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 1>>
    %296 = tensor.empty() : tensor<1x!ckks.poly<2 * 1>>
    %297 = "ckks.addcc"(%296, %295, %281) : (tensor<1x!ckks.poly<2 * 1>>, tensor<1x!ckks.poly<2 * 1>>, tensor<1x!ckks.poly<2 * 1>>) -> tensor<1x!ckks.poly<2 * 1>>
    %298 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %299 = "ckks.modswitchc"(%298, %139) <{downFactor = 1 : i64}> : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 4>>) -> tensor<1x!ckks.poly<2 * 3>>
    %300 = tensor.empty() : tensor<1x!ckks.poly<2 * 3>>
    %301 = tensor.empty() : tensor<1x!ckks.poly<1 * 3>>
    %302 = "ckks.encode"(%301) <{level = 3 : i64, scale = 20 : i64, value = -1 : i64}> : (tensor<1x!ckks.poly<1 * 3>>) -> tensor<1x!ckks.poly<1 * 3>>
    %303 = "ckks.mulcp"(%300, %299, %302) : (tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<2 * 3>>, tensor<1x!ckks.poly<1 * 3>>) -> tensor<1x!ckks.poly<2 * 3>>
    %304 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %305 = "ckks.rescalec"(%304, %303) : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 3>>) -> tensor<1x!ckks.poly<2 * 2>>
    %306 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %307 = tensor.empty() : tensor<1x!ckks.poly<1 * 2>>
    %308 = "ckks.encode"(%307) <{level = 2 : i64, scale = 20 : i64, value = -1 : i64}> : (tensor<1x!ckks.poly<1 * 2>>) -> tensor<1x!ckks.poly<1 * 2>>
    %309 = "ckks.mulcp"(%306, %305, %308) : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<1 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    %310 = tensor.empty() : tensor<1x!ckks.poly<2 * 2>>
    %311 = "ckks.addcc"(%310, %309, %287) : (tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>, tensor<1x!ckks.poly<2 * 2>>) -> tensor<1x!ckks.poly<2 * 2>>
    return %297, %311 : tensor<1x!ckks.poly<2 * 1>>, tensor<1x!ckks.poly<2 * 2>>
  }
}