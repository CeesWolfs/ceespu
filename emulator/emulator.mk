##
## Auto Generated makefile by CodeLite IDE
## any manual changes will be erased      
##
## Debug
ProjectName            :=emulator
ConfigurationName      :=Debug
WorkspacePath          :=/home/cees/Documents/repos/ceespu
ProjectPath            :=/home/cees/Documents/repos/ceespu/emulator
IntermediateDirectory  :=./Debug
OutDir                 := $(IntermediateDirectory)
CurrentFileName        :=
CurrentFilePath        :=
CurrentFileFullPath    :=
User                   :=cees
Date                   :=07/14/18
CodeLitePath           :=/home/cees/.codelite
LinkerName             :=/usr/bin/clang++
SharedObjectLinkerName :=/usr/bin/clang++ -shared -fPIC
ObjectSuffix           :=.o
DependSuffix           :=.o.d
PreprocessSuffix       :=.i
DebugSwitch            :=-g 
IncludeSwitch          :=-I
LibrarySwitch          :=-l
OutputSwitch           :=-o 
LibraryPathSwitch      :=-L
PreprocessorSwitch     :=-D
SourceSwitch           :=-c 
OutputFile             :=$(IntermediateDirectory)/$(ProjectName)
Preprocessors          :=
ObjectSwitch           :=-o 
ArchiveOutputSwitch    := 
PreprocessOnlySwitch   :=-E
ObjectsFileList        :="emulator.txt"
PCHCompileFlags        :=
MakeDirCommand         :=mkdir -p
LinkOptions            :=  -lSDL2 -pthread
IncludePath            :=  $(IncludeSwitch). $(IncludeSwitch). 
IncludePCH             := 
RcIncludePath          := 
Libs                   := 
ArLibs                 :=  
LibPath                := $(LibraryPathSwitch). 

##
## Common variables
## AR, CXX, CC, AS, CXXFLAGS and CFLAGS can be overriden using an environment variables
##
AR       := /usr/bin/ar rcu
CXX      := /usr/bin/clang++
CC       := /usr/bin/clang
CXXFLAGS := -std=c++17 -lpthread -g -O0 -Wall -lSDL2 -pthread $(Preprocessors)
CFLAGS   :=  -g -O0 -Wall $(Preprocessors)
ASFLAGS  := 
AS       := /usr/bin/as


##
## User defined environment variables
##
CodeLiteDir:=/usr/share/codelite
Objects0=$(IntermediateDirectory)/video.cpp$(ObjectSuffix) $(IntermediateDirectory)/receive.cpp$(ObjectSuffix) $(IntermediateDirectory)/ceespu.cpp$(ObjectSuffix) 



Objects=$(Objects0) 

##
## Main Build Targets 
##
.PHONY: all clean PreBuild PrePreBuild PostBuild MakeIntermediateDirs
all: $(OutputFile)

$(OutputFile): $(IntermediateDirectory)/.d $(Objects) 
	@$(MakeDirCommand) $(@D)
	@echo "" > $(IntermediateDirectory)/.d
	@echo $(Objects0)  > $(ObjectsFileList)
	$(LinkerName) $(OutputSwitch)$(OutputFile) @$(ObjectsFileList) $(LibPath) $(Libs) $(LinkOptions)

MakeIntermediateDirs:
	@test -d ./Debug || $(MakeDirCommand) ./Debug


$(IntermediateDirectory)/.d:
	@test -d ./Debug || $(MakeDirCommand) ./Debug

PreBuild:


##
## Objects
##
$(IntermediateDirectory)/video.cpp$(ObjectSuffix): video.cpp $(IntermediateDirectory)/video.cpp$(DependSuffix)
	$(CXX) $(IncludePCH) $(SourceSwitch) "/home/cees/Documents/repos/ceespu/emulator/video.cpp" $(CXXFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/video.cpp$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/video.cpp$(DependSuffix): video.cpp
	@$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/video.cpp$(ObjectSuffix) -MF$(IntermediateDirectory)/video.cpp$(DependSuffix) -MM video.cpp

$(IntermediateDirectory)/video.cpp$(PreprocessSuffix): video.cpp
	$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/video.cpp$(PreprocessSuffix) video.cpp

$(IntermediateDirectory)/receive.cpp$(ObjectSuffix): receive.cpp $(IntermediateDirectory)/receive.cpp$(DependSuffix)
	$(CXX) $(IncludePCH) $(SourceSwitch) "/home/cees/Documents/repos/ceespu/emulator/receive.cpp" $(CXXFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/receive.cpp$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/receive.cpp$(DependSuffix): receive.cpp
	@$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/receive.cpp$(ObjectSuffix) -MF$(IntermediateDirectory)/receive.cpp$(DependSuffix) -MM receive.cpp

$(IntermediateDirectory)/receive.cpp$(PreprocessSuffix): receive.cpp
	$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/receive.cpp$(PreprocessSuffix) receive.cpp

$(IntermediateDirectory)/ceespu.cpp$(ObjectSuffix): ceespu.cpp $(IntermediateDirectory)/ceespu.cpp$(DependSuffix)
	$(CXX) $(IncludePCH) $(SourceSwitch) "/home/cees/Documents/repos/ceespu/emulator/ceespu.cpp" $(CXXFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/ceespu.cpp$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/ceespu.cpp$(DependSuffix): ceespu.cpp
	@$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/ceespu.cpp$(ObjectSuffix) -MF$(IntermediateDirectory)/ceespu.cpp$(DependSuffix) -MM ceespu.cpp

$(IntermediateDirectory)/ceespu.cpp$(PreprocessSuffix): ceespu.cpp
	$(CXX) $(CXXFLAGS) $(IncludePCH) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/ceespu.cpp$(PreprocessSuffix) ceespu.cpp


-include $(IntermediateDirectory)/*$(DependSuffix)
##
## Clean
##
clean:
	$(RM) -r ./Debug/


