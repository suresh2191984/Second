using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Web.UI;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.pdf.draw;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using iTextSharp.tool.xml;
using iTextSharp.tool.xml.html;
using iTextSharp.tool.xml.parser;
using iTextSharp.tool.xml.css;
using iTextSharp.tool.xml.pipeline.html;
using iTextSharp.tool.xml.pipeline.css;
using iTextSharp.tool.xml.pipeline.end;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;

public partial class NotesPatternReport : BaseControl
{
    public NotesPatternReport()
    {

    }

    public long GenerateReport(Int32 OrgID, Int64 VisitID, Int32 TemplateID, Int64 InvestigationID, out byte[] output)
    {
        long returnCode = -1;
        output = new byte[byte.MaxValue];
        try
        {
            List<PatientDemography> lstPatientDemoGraphy = new List<PatientDemography>();
            Investigation_BL objInvestigation_BL = new Investigation_BL(new BaseClass().ContextInfo);
            returnCode = objInvestigation_BL.GetPatientDemography(OrgID, VisitID, out lstPatientDemoGraphy);

            if (lstPatientDemoGraphy.Count > 0)
            {

                Document document = new Document(new Rectangle(612, 792));
                document.SetMargins(50f, 50f, 140f, 120f);
                MemoryStream memoryStream = new MemoryStream();
                PdfWriter writer = PdfWriter.GetInstance(document, memoryStream);

                Font labelFont = FontFactory.GetFont("Trebuchet MS", 10, Font.BOLD);
                Font titleFont = FontFactory.GetFont("Trebuchet MS", 10, Font.BOLD);
                Font titleTextFont = FontFactory.GetFont("Trebuchet MS", 10);
                Font textFont = FontFactory.GetFont("Trebuchet MS", 9);
                Font qualityFont = FontFactory.GetFont("Trebuchet MS", 9, Font.ITALIC);

                Attune.Podium.BusinessEntities.Login login = new Attune.Podium.BusinessEntities.Login();
                returnCode = objInvestigation_BL.GetImageForApproval(OrgID, VisitID, InvestigationID, out login);
                byte[] byteArray = login.ImageSource;

                PdfPTable footerTable = new PdfPTable(2);
                footerTable.WidthPercentage = 100;
                footerTable.TotalWidth = document.PageSize.Width - (document.LeftMargin + document.RightMargin);
                footerTable.SplitLate = false;
                footerTable.DefaultCell.BorderWidth = 0;
                footerTable.DefaultCell.Padding = 2;
                footerTable.DefaultCell.SpaceCharRatio = 2;
                footerTable.DefaultCell.NoWrap = false;
                footerTable.DefaultCell.HorizontalAlignment = Element.ALIGN_LEFT;
                footerTable.SetWidths(new int[2] { 500, 250 });

                PdfPCell footerCell;
                if (login.LoginID > 0 && login.ImageSource != null && byteArray.Count() > 0)
                {
                    footerTable.AddCell(new Phrase("Quality controlled report with external quality assurance.", qualityFont));

                    footerCell = new PdfPCell(iTextSharp.text.Image.GetInstance(byteArray));
                    footerCell.BorderWidth = 0;
                    footerCell.HorizontalAlignment = Element.ALIGN_CENTER;
                    footerTable.AddCell(footerCell);
                }
                else
                {
                    List<InvReportTemplateFooter> lstInvReportFooter = new List<InvReportTemplateFooter>();
                    returnCode = new Investigation_BL(base.ContextInfo).GetInvreportFooter(OrgID, InvestigationID, out lstInvReportFooter);

                    footerCell = new PdfPCell();
                    footerCell.BorderWidth = 0;
                    footerCell.HorizontalAlignment = Element.ALIGN_CENTER;

                    if (lstInvReportFooter.Count > 0)
                    {
                        footerTable.AddCell(string.Empty);
                        footerCell.AddElement(new Phrase(lstInvReportFooter[0].Name, labelFont));
                        footerTable.AddCell(footerCell);

                        footerTable.AddCell(new Phrase("Quality controlled report with external quality assurance.", qualityFont));
                        footerCell = new PdfPCell();
                        footerCell.AddElement(new Phrase(lstInvReportFooter[0].Title, labelFont));
                        footerCell.BorderWidth = 0;
                        footerCell.HorizontalAlignment = Element.ALIGN_CENTER;
                        footerTable.AddCell(footerCell);
                    }
                    else
                    {
                        footerTable.AddCell(new Phrase("Quality controlled report with external quality assurance.", qualityFont));
                        footerTable.AddCell(string.Empty);
                    }
                }

                writer.PageEvent = new PdfPageEvents(footerTable);

                document.Open();

                PdfPTable table = new PdfPTable(8);
                table.WidthPercentage = 100;
                table.HeaderRows = 6;
                table.SplitLate = false;
                table.DefaultCell.BorderWidth = 0;
                table.DefaultCell.NoWrap = false;
                table.DefaultCell.Padding = 2;
                table.DefaultCell.SpaceCharRatio = 2;
                table.SetWidths(new int[8] { 130, 30, 330, 15, 210, 30, 250, 10 });

                table.AddCell(new Phrase("Name", labelFont));
                table.AddCell(new Phrase(":", labelFont));
                table.AddCell(new Phrase(lstPatientDemoGraphy[0].PatientName, titleTextFont));
                table.AddCell(string.Empty);
                table.AddCell(new Phrase("Reg. Date/Time", labelFont));
                table.AddCell(new Phrase(":", labelFont));
                table.AddCell(new Phrase(lstPatientDemoGraphy[0].VisitDate != null ? lstPatientDemoGraphy[0].VisitDate.ToString() : string.Empty, titleTextFont));

                PdfPCell headerCell = new PdfPCell(new Phrase("REPORT", titleFont));
                headerCell.BorderWidth = 0;
                headerCell.Rowspan = 6;
                table.AddCell(headerCell);

                table.AddCell(new Phrase("Perm No.", labelFont));
                table.AddCell(new Phrase(":", labelFont));
                table.AddCell(new Phrase(lstPatientDemoGraphy[0].PatientID, titleTextFont));
                table.AddCell(string.Empty);
                table.AddCell(new Phrase("Reported Date/Time", labelFont));
                table.AddCell(new Phrase(":", labelFont));
                table.AddCell(new Phrase(lstPatientDemoGraphy[0].ReportedOn != null ? lstPatientDemoGraphy[0].ReportedOn.ToString() : string.Empty, titleTextFont));

                table.AddCell(new Phrase("Visit No.", labelFont));
                table.AddCell(new Phrase(":", labelFont));
                table.AddCell(new Phrase(lstPatientDemoGraphy[0].ExternalVisitId, titleTextFont));
                table.AddCell(string.Empty);
                table.AddCell(new Phrase("Printed Date/Time", labelFont));
                table.AddCell(new Phrase(":", labelFont));
                table.AddCell(new Phrase(lstPatientDemoGraphy[0].PrintedOn != null ? lstPatientDemoGraphy[0].PrintedOn.ToString() : string.Empty, titleTextFont));

                table.AddCell(new Phrase("Gender/Age", labelFont));
                table.AddCell(new Phrase(":", labelFont));
                table.AddCell(new Phrase(lstPatientDemoGraphy[0].Sex + " / " + lstPatientDemoGraphy[0].Age, titleTextFont));
                table.AddCell(string.Empty);
                table.AddCell(new Phrase("Ref. Client", labelFont));
                table.AddCell(new Phrase(":", labelFont));
                table.AddCell(new Phrase(lstPatientDemoGraphy[0].ClientName != null ? lstPatientDemoGraphy[0].ClientName : string.Empty, titleTextFont));

                table.AddCell(new Phrase("Ref. Dr.", labelFont));
                table.AddCell(new Phrase(":", labelFont));
                table.AddCell(new Phrase(lstPatientDemoGraphy[0].ReferingPhysicianName, titleTextFont));
                table.AddCell(string.Empty);
                table.AddCell(new Phrase("Ref. Hospital", labelFont));
                table.AddCell(new Phrase(":", labelFont));
                table.AddCell(new Phrase(lstPatientDemoGraphy[0].HospitalName != null ? lstPatientDemoGraphy[0].HospitalName : string.Empty, titleTextFont));

                List<InvestigationValues> lstInvestigationValues = new List<InvestigationValues>();
                returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetInvestigationValuesForID(OrgID, VisitID, TemplateID, InvestigationID, out lstInvestigationValues);

                if (lstInvestigationValues.Count > 0)
                {
                    Chunk chunk = new Chunk(new LineSeparator(1f, 100, BaseColor.BLACK, Element.ALIGN_CENTER, 3.5f));
                    PdfPCell cell;

                    cell = new PdfPCell();
                    cell.BorderWidth = 0;
                    cell.Colspan = 8;
                    cell.AddElement(chunk);
                    table.AddCell(cell);

                    //cell = new PdfPCell(new Phrase(lstInvestigationValues[0].InvestigationName, titleFont));
                    //cell.BorderWidth = 0;
                    //cell.HorizontalAlignment = 1;
                    //cell.Colspan = 8;
                    //table.AddCell(cell);

                    string htmlContent = lstInvestigationValues[0].Value;
                    List<IElement> parsedHtmlElements = HTMLWorker.ParseToList(new StringReader(htmlContent), null);

                    cell = new PdfPCell();
                    cell.BorderWidth = 0;
                    cell.Colspan = 8;
                    cell.NoWrap = false;
                    foreach (IElement htmlElement in parsedHtmlElements)
                    {
                        cell.AddElement(htmlElement);
                    }
                    table.AddCell(cell);
                }
                else
                {
                    table.AddCell("");
                }
                document.Add(table);
                writer.CloseStream = false;
                document.Close();
                memoryStream.Position = 0;

                output = memoryStream.ToArray();
                memoryStream.Dispose();
            }
            returnCode = 0;
        }
        catch (Exception ex)
        {
            returnCode = -1;
            CLogger.LogError("Error in generating notes pattern report ", ex);
        }
        return returnCode;
    }
}
internal class PdfPageEvents : IPdfPageEvent
{
    #region members

    private PdfContentByte _content;
    private PdfPTable _footerTable;

    #endregion

    #region IPdfPageEvent Members

    public PdfPageEvents(PdfPTable footerTable)
    {
        _footerTable = footerTable;
    }

    public void OnOpenDocument(PdfWriter writer, Document document)
    {
        _content = writer.DirectContent;
    }

    public void OnStartPage(PdfWriter writer, Document document)
    {
    }

    public void OnEndPage(PdfWriter writer, Document document)
    {
        // Write footer text (page numbers)
        _footerTable.WriteSelectedRows(0, -1, document.LeftMargin, document.BottomMargin - 10, writer.DirectContent);
    }

    public void OnCloseDocument(PdfWriter writer, Document document)
    {
    }

    public void OnParagraph(PdfWriter writer, Document document, float paragraphPosition)
    {
    }

    public void OnParagraphEnd(PdfWriter writer, Document document, float paragraphPosition)
    {
    }

    public void OnChapter(PdfWriter writer, Document document, float paragraphPosition, Paragraph title)
    {
    }

    public void OnChapterEnd(PdfWriter writer, Document document, float paragraphPosition)
    {
    }

    public void OnSection(PdfWriter writer, Document document, float paragraphPosition, int depth, Paragraph title)
    {
    }

    public void OnSectionEnd(PdfWriter writer, Document document, float paragraphPosition)
    {
    }

    public void OnGenericTag(PdfWriter writer, Document document, Rectangle rect, string text)
    {
    }

    #endregion
}